import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';

import 'font_builder.dart';
import 'snapshot_device.dart';
import 'snapshot_support.dart';
import 'test_tool.dart';

class Snapshot extends TestTool {
  Snapshot({required this.directoryPath, required this.devices});

  final String directoryPath;
  final List<SnapshotDevice> devices;

  @override
  Future<void> run(Playbook playbook, PlaybookBuilder builder) async {
    setUpAll(() async {
      await FontBuilder.loadFonts();
    });

    for (final device in devices) {
      final ensuredDirectoryPath = '$directoryPath/${device.name}';

      for (final story in playbook.stories) {
        for (final scenario in story.scenarios) {
          final scenarioWidget = builder(ScenarioWidget(scenario: scenario));

          testWidgets('Snapshot for ${story.title} ${scenario.title}', (tester) async {
            await SnapshotSupport.startDevice(scenarioWidget, tester, device);
            await SnapshotSupport.resize(scenarioWidget, scenario, tester, device);

            await expectLater(
              find.byWidget(scenario.child),
              matchesGoldenFile('$ensuredDirectoryPath/${story.title}/${scenario.title}.png'),
            );
          });
        }
      }
    }
  }
}
