import 'dart:async';

import 'package:flutter/material.dart';
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
  Future<void> run(Playbook playbook, PlaybookBuilder builder) async {
    setUpAll(() async {
      await FontBuilder.loadFonts();
    });

    for (final device in devices) {
      final sub = subdirectoryPath != null ? '/$subdirectoryPath' : '';
      final ensuredDirectoryPath = '$directoryPath/${device.name}$sub';

      for (final story in playbook.stories) {
        for (final scenario in story.scenarios) {
          final scenarioWidget = builder(ScenarioWidget(scenario: scenario));

          testWidgets('Snapshot for ${story.title} ${scenario.title}',
              (tester) async {
            await SnapshotSupport.startDevice(scenarioWidget, tester, device);
            await SnapshotSupport.resize(
                scenarioWidget, scenario, tester, device);
            await SnapshotSupport.precacheAssetImage(tester);

            await expectLater(
              find.byWidget(scenario.child),
              matchesGoldenFile(
                  '$ensuredDirectoryPath/${story.title}/${scenario.title}.png'),
            );
          });
        }
      }
    }
  }
}
