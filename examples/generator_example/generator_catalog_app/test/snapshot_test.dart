import 'package:generator_app/generated_playbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook_snapshot/playbook_snapshot.dart';

Future<void> main() async {
  await playbook.run(
    Snapshot(
      directoryPath: 'screenshots',
      devices: [
        SnapshotDevice.iPhone8,
      ],
    ),
    (widget) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget,
      );
    },
  );
}
