import 'package:flutter/material.dart';
import 'playbook.dart';

typedef PlaybookBuilder = Widget Function(Widget);

abstract class TestTool {
  Future<void> run(Playbook playbook, PlaybookBuilder builder);
}
