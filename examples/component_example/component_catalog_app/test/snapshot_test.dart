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
          SnapshotDevice.iPhoneSE2nd,
        ],
      ),
      tester,
      (widget, device) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Roboto',
            platform: device.platform,
          ),
          home: Material(child: widget),
        );
      },
    );
  });
}
