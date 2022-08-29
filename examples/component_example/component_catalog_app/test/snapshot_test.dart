import 'package:component_catalog_app/generated_playbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook_snapshot/playbook_snapshot.dart';

Future<void> main() async {
  testWidgets('Take snapshots', (tester) async {
    await playbook.run(
      Snapshot(
        directoryPath: 'screenshots',
        devices: [
          SnapshotDevice(
            name: 'iPhone8',
            size: Size(375, 667),
            platform: TargetPlatform.iOS,
          ),
        ],
      ),
      tester,
      (widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Material(child: widget),
        );
      },
    );
  });
}
