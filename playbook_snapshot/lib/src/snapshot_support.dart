import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';

import 'snapshot_device.dart';

class SnapshotSupport {
  static Future<void> startDevice(
    Widget target,
    WidgetTester tester,
    SnapshotDevice device,
  ) async {
    tester.binding.window.devicePixelRatioTestValue = 1;
    await _setSnapshotSize(tester, device.size);
    await tester.pumpWidget(target);
    await tester.pumpAndSettle();
  }

  static Future<void> resize(
    Widget target,
    Scenario scenario,
    WidgetTester tester,
    SnapshotDevice device,
  ) async {
    if (!scenario.layout.needsResizing) {
      return;
    }

    var absoluteSize = Size(scenario.layout.absoluteWidth(device),
        scenario.layout.absoluteHeight(device));

    if (scenario.layout.needsCompressedResizing) {
      final scrollViews = find
          .byWidgetPredicate((widget) => widget is ScrollView)
          .evaluate()
          .map((e) => e.widget as ScrollView);

      absoluteSize = device.size;

      for (final scrollView in scrollViews) {
        absoluteSize =
            _extendScrollableSnapshotSize(scrollView, absoluteSize, device);
      }
    }

    await _setSnapshotSize(tester, absoluteSize);
    await tester.pumpAndSettle();
  }

  // see: https://github.com/flutter/flutter/issues/38997
  static Future<void> precacheAssetImage(
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      for (var element in find.byType(Image).evaluate()) {
        final Image widget = element.widget as Image;
        final ImageProvider image = widget.image;
        await precacheImage(image, element);
        await tester.pumpAndSettle();
      }
    });
  }

  static Future<void> _setSnapshotSize(WidgetTester tester, Size size) async {
    await tester.binding.setSurfaceSize(size);
    tester.binding.window.physicalSizeTestValue = size;
  }

  static Size _extendScrollableSnapshotSize(
    ScrollView scrollView,
    Size absoluteSize,
    SnapshotDevice device,
  ) {
    final controller = scrollView.controller;
    if (controller == null) {
      return device.size;
    }

    final scrollAxis = controller.position.axis;
    final maxScrollExtent = controller.position.maxScrollExtent;

    if (scrollAxis == Axis.horizontal) {
      final height = max(device.size.height, absoluteSize.height);
      final width = maxScrollExtent + device.size.width;
      return Size(width, height);
    } else if (scrollAxis == Axis.vertical) {
      final height = maxScrollExtent + device.size.height;
      final width = max(device.size.width, absoluteSize.width);
      return Size(width, height);
    }

    return absoluteSize;
  }
}

extension on ScenarioLayout {
  bool get needsResizing {
    return !(v is ScenarioLayoutFill && h is ScenarioLayoutFill);
  }

  bool get needsCompressedResizing {
    return v is ScenarioLayoutCompressed || h is ScenarioLayoutCompressed;
  }

  double absoluteWidth(SnapshotDevice device) {
    switch (h.runtimeType) {
      case ScenarioLayoutFixed:
        return (h as ScenarioLayoutFixed).value;
      case ScenarioLayoutFill:
        return device.size.width;
      case ScenarioLayoutCompressed:
        return 0;
    }
    return device.size.width;
  }

  double absoluteHeight(SnapshotDevice device) {
    switch (v.runtimeType) {
      case ScenarioLayoutFixed:
        return (v as ScenarioLayoutFixed).value;
      case ScenarioLayoutFill:
        return device.size.height;
      case ScenarioLayoutCompressed:
        return 0;
    }
    return device.size.height;
  }
}
