import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_snapshot/playbook_snapshot.dart';
import 'package:simple_catalog_app/bar/bar.dart';
import 'package:simple_catalog_app/foo/foo_widget.dart';
import 'package:simple_catalog_app/image/asset_image.dart';

Future<void> main() async {
  await Playbook(
    stories: [
      barStory(),
      fooWidgetStory(),
      assetImageStory(),
    ],
  ).run(
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
