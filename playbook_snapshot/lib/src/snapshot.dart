import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_snapshot/src/font_builder.dart';
import 'package:playbook_snapshot/src/snapshot_base.dart';
import 'package:playbook_snapshot/src/snapshot_device.dart';
import 'package:playbook_snapshot/src/snapshot_support.dart';
import 'package:playbook_snapshot/src/test_tool.dart';

class Snapshot implements TestTool {
  const Snapshot({
    this.canvasColor = Colors.white,
    this.checkeredColor = Colors.black12,
    this.useMaterial = true,
    required this.directoryPath,
    required this.devices,
    this.subdirectoryPath,
  });

  final Color? canvasColor;
  final Color? checkeredColor;
  final bool useMaterial;
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
      debugDefaultTargetPlatformOverride = device.platform;

      for (final story in playbook.stories) {
        for (final scenario in story.scenarios) {
          tester
              .printToConsole('Snapshot for ${story.title} ${scenario.title}');
          stopwatch.reset();

          runApp(Container(key: UniqueKey()));
          final snapshotWidget = builder(
            ScenarioWidget(
              canvasColor: canvasColor,
              checkeredColor: checkeredColor,
              checkeredRectSize: checkeredRectSize,
              useMaterial: useMaterial,
              scenario: scenario,
            ),
            device,
          );

          final target = Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  padding: device.safeAreaInsets,
                  viewPadding: device.safeAreaInsets,
                  devicePixelRatio: device.pixelRatio,
                  textScaler: device.textScaler,
                ),
                child: snapshotWidget,
              );
            },
          );
          await tester.runAsync(() async {
            await SnapshotSupport.startDevice(target, tester, device);
            await SnapshotSupport.resize(
              target,
              scenario,
              tester,
              device,
            );
            await SnapshotSupport.precacheAssetImage(tester);

            await setUpEachTest?.call(tester);
          });

          await expectLater(
            find.byWidget(target),
            matchesGoldenFile(
              '$ensuredDirectoryPath/${story.title}/${scenario.title}.png',
            ),
          );
          tester.printToConsole(
            'Snapshot finished in ${stopwatch.elapsedMilliseconds / 1000}s',
          );
        }
      }
    }
    // To avoid EXCEPTION CAUGHT
    debugDefaultTargetPlatformOverride = null;
  }
}
