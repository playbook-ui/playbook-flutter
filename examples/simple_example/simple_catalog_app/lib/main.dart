import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_ui/playbook_ui.dart';
import 'package:simple_catalog_app/bar/bar.dart';
import 'package:simple_catalog_app/foo/foo_widget.dart';
import 'package:simple_catalog_app/hero/multiple_hero.dart';
import 'package:simple_catalog_app/image/asset_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playbook Demo',
      theme: _isDark ? ThemeData.dark() : ThemeData.light(),
      home: PlaybookGallery(
        title: 'Sample app',
        onCustomActionPressed: () => setState(() {
          _isDark = !_isDark;
        }),
        playbook: Playbook(
          stories: [
            barStory(),
            fooWidgetStory(),
            assetImageStory(),
            multipleHeroStoryForTest(),
          ],
        ),
      ),
    );
  }
}
