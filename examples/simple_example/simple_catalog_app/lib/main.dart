import 'package:simple_app/bar/bar.story.dart';
import 'package:simple_app/foo/foo_widget.story.dart';
import 'package:simple_app/image/asset_image.story.dart';
import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_ui/playbook_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playbook Demo',
      theme: ThemeData.light(),
      home: PlaybookGallery(
        playbook: Playbook(
          stories: [
            barStory(),
            fooWidgetStory(),
            assetImageStory(),
          ],
        ),
      ),
    );
  }
}
