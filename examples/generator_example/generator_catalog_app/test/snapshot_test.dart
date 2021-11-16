import 'package:generator_app/generated_playbook.dart';
import 'package:generator_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook_snapshot/playbook_snapshot.dart';

Future<void> main() async {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized;
  });

  Future<void> _runSnapshot({
    required TargetPlatform platform,
    required List<SnapshotDevice> devices,
  }) async {
    packageName = 'app';
    await playbook.run(
      Snapshot(directoryPath: 'screenshots', devices: devices),
      (widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: widget,
        );
      },
    );
  }

  await _runSnapshot(
    platform: TargetPlatform.iOS,
    devices: [SnapshotDevice.iPhone8],
  );
}
