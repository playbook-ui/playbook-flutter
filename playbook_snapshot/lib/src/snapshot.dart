import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';

import 'font_builder.dart';
import 'snapshot_device.dart';
import 'snapshot_support.dart';
import 'test_tool.dart';

class Snapshot implements TestTool {
  const Snapshot({
    required this.directoryPath,
    required this.devices,
    this.subdirectoryPath,
  });

  final String directoryPath;
  final List<SnapshotDevice> devices;
  final String? subdirectoryPath;

  @override
  Future<void> run(
    Playbook playbook,
    WidgetTester tester,
    PlaybookBuilder builder, {
    Future<void> Function(WidgetTester tester)? setUpEachTest,
  }) async {
    await tester.runAsync(() async {
      await FontBuilder.loadFonts();
      await tester.pumpAndSettle();
    });
    final stopwatch = Stopwatch()..start();

    for (final device in devices) {
      final sub = subdirectoryPath != null ? '/$subdirectoryPath' : '';
      final ensuredDirectoryPath = '$directoryPath/${device.name}$sub';

      for (final story in playbook.stories) {
        for (final scenario in story.scenarios) {
          tester.printToConsole('Snapshot for ${story.title} ${scenario.title}');
          stopwatch.reset();

          final scenarioWidget = builder(ScenarioWidget(scenario: scenario));
          await SnapshotSupport.startDevice(scenarioWidget, tester, device);
          await SnapshotSupport.resize(scenarioWidget, scenario, tester, device);
          await SnapshotSupport.precacheAssetImage(tester);

          await setUpEachTest?.call(tester);

          await expectLater(
            find.byWidget(scenario.child),
            matchesGoldenFile('$ensuredDirectoryPath/${story.title}/${scenario.title}.png'),
          );
          tester.printToConsole('Snapshot finished in ${stopwatch.elapsedMilliseconds / 1000}s');
        }
      }
    }
  }
}
