import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_snapshot/src/snapshot_device.dart';

typedef PlaybookBuilder = Widget Function(Widget, SnapshotDevice);

abstract class TestTool {
  Future<void> run(
    Playbook playbook,
    WidgetTester tester,
    PlaybookBuilder builder, {
    ScenarioWidgetBuilder? scenarioWidgetBuilder,
    Future<void> Function(WidgetTester tester)? setUpEachTest,
  });
}

extension PlaybookExt on Playbook {
  Future<void> run(
    TestTool test,
    WidgetTester tester,
    PlaybookBuilder builder, {
    ScenarioWidgetBuilder? scenarioWidgetBuilder,
    Future<void> Function(WidgetTester tester)? setUpEachTest,
  }) async {
    await test.run(
      this,
      tester,
      builder,
      scenarioWidgetBuilder: scenarioWidgetBuilder,
      setUpEachTest: setUpEachTest,
    );
  }
}
