import 'package:generator_app/generated_playbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook_snapshot/playbook_snapshot.dart';

Future<void> main() async {
  testWidgets('Take snapshots', (tester) async {
    await playbook.run(
      Snapshot(
        directoryPath: 'screenshots',
        devices: [
          SnapshotDevice.iPhone8,
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
