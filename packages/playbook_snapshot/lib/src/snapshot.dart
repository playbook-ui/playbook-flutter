import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_snapshot/src/font_builder.dart';
import 'package:playbook_snapshot/src/pubspec_reader.dart';
import 'package:playbook_snapshot/src/snapshot_device.dart';
import 'package:playbook_snapshot/src/snapshot_support.dart';
import 'package:playbook_snapshot/src/test_tool.dart';

class Snapshot implements TestTool {
  const Snapshot({
    this.canvasColor = Colors.white,
    this.checkeredColor = Colors.black12,
    this.checkeredRectSize,
    this.useMaterial = true,
    this.snapshotDir,
    this.subDir,
    @Deprecated(
      '''Write a snapshot_dir in playbook_snapshot in pubspec.yaml or use snapshotDir instead.''',
    )
    this.directoryPath,
    required this.devices,
    @Deprecated(
      '''Write a sub_dir in playbook_snapshot in pubspec.yaml or use subDir instead.''',
    )
    this.subdirectoryPath,
  });

  static const _snapshotDir = 'snapshots';

  final Color? canvasColor;
  final Color? checkeredColor;
  final double? checkeredRectSize;
  final bool useMaterial;
  final String? snapshotDir;
  final String? subDir;
  final List<SnapshotDevice> devices;
  // ignore: deprecated_consistency
  final String? directoryPath;
  // ignore: deprecated_consistency
  final String? subdirectoryPath;

  @override
  Future<void> run(
    Playbook playbook,
    WidgetTester tester,
    PlaybookBuilder builder, {
    ScenarioWidgetBuilder? scenarioWidgetBuilder,
    Future<void> Function(WidgetTester tester)? setUpEachTest,
  }) async {
    await tester.runAsync(() async {
      await FontBuilder.loadFonts();
      await tester.pumpAndSettle();
    });
    final stopwatch = Stopwatch()..start();

    final spec = PubspecReader.read('playbook_snapshot');
    final dirPath = snapshotDir ??
        spec?['snapshot_dir'] as String? ??
        directoryPath ??
        _snapshotDir;
    final subDirPath =
        subDir ?? spec?['sub_dir'] as String? ?? subdirectoryPath;
    final subPath = subDirPath != null ? '/$subDirPath' : '';

    for (final device in devices) {
      final ensuredDirectoryPath = '$dirPath/${device.name}$subPath';
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
              builder: scenarioWidgetBuilder,
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
