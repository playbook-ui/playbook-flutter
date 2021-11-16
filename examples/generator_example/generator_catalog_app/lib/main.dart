import 'package:generator_app/generated_playbook.dart';
import 'package:flutter/material.dart';
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
        playbook: playbook,
      ),
    );
  }
}
