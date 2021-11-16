import 'package:simple_app/bar/bar.story.dart';
import 'package:simple_app/foo/foo_widget.story.dart';
import 'package:simple_app/image/asset_image.story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_snapshot/playbook_snapshot.dart';

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
