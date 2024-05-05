import 'package:generator_app/generated_playbook.dart';
import 'package:flutter/material.dart';
import 'package:playbook_ui/playbook_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _isDark = false;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playbook Demo',
      theme: _isDark ? ThemeData.dark() : ThemeData.light(),
      home: PlaybookGallery(
        title: 'Generator app',
        searchTextController: controller,
        checkeredColor: null,
        onCustomActionPressed: () => setState(() {
          _isDark = !_isDark;
        }),
        playbook: playbook,
      ),
    );
  }
}
