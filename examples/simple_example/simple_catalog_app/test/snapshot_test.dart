import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_snapshot/playbook_snapshot.dart';
import 'package:simple_catalog_app/bar/bar.dart';
import 'package:simple_catalog_app/foo/foo_widget.dart';
import 'package:simple_catalog_app/image/asset_image.dart';
import 'package:simple_catalog_app/scrollable/scrollable.dart';

Future<void> main() async {
  testWidgets('Take snapshots', (tester) async {
    await Playbook(
      stories: [
        barStory(),
        fooWidgetStory(),
        assetImageStory(),
        scrollableStory(),
      ],
    ).run(
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
