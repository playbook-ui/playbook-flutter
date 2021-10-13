import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';

typedef PlaybookBuilder = Widget Function(Widget);

abstract class TestTool {
  Future<void> run(
    Playbook playbook,
    PlaybookBuilder builder, {
    Future<void> Function(WidgetTester tester)? setUpEachTest,
  });
}

extension PlaybookExt on Playbook {
  Future<void> run(
    TestTool test,
    PlaybookBuilder builder, {
    Future<void> Function(WidgetTester tester)? setUpEachTest,
  }) async {
    await test.run(
      this,
      builder,
      setUpEachTest: setUpEachTest,
    );
  }
}
