import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

typedef PlaybookBuilder = Widget Function(Widget);

abstract class TestTool {
  Future<void> run(Playbook playbook, PlaybookBuilder builder);
}

extension PlaybookExt on Playbook {
  Future<void> run(TestTool test, PlaybookBuilder builder) async {
    await test.run(this, builder);
  }
}
