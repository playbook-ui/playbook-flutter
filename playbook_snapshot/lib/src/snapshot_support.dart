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

    final absoluteSize = Size(
      scenario.layout.absoluteWidth(device),
      scenario.layout.absoluteHeight(device),
    );

    Size snapshotSize;
    if (scenario.layout.needsCompressedResizing) {
      // We use scrollController.maxScrollExtent to calculate the snapshot size.
      // However, maxScrollExtent may report incorrectly.
      // To solve this, we repeatedly calculate size and update size until we can get a stable value.
      var lastExtendedSize = device.size;
      while (true) {
        final scrollViews = find
            .byWidgetPredicate((widget) => widget is ScrollView)
            .evaluate()
            .map((e) => e.widget as ScrollView);
        if (scrollViews.isEmpty) break;

        var extendedSize = device.size;
        for (final scrollView in scrollViews) {
          extendedSize = _extendScrollableSnapshotSize(
            scrollView: scrollView,
            extendedSize: extendedSize,
            originSize: lastExtendedSize,
          );
        }
        if (extendedSize <= lastExtendedSize) break;
        lastExtendedSize = extendedSize;
        await _setSnapshotSize(tester, lastExtendedSize);
      }
      snapshotSize = lastExtendedSize;
    } else {
      snapshotSize = absoluteSize;
    }
    await _setSnapshotSize(tester, snapshotSize);
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
    await tester.pumpAndSettle();
  }

  static Size _extendScrollableSnapshotSize({
    required ScrollView scrollView,
    required Size extendedSize,
    required Size originSize,
  }) {
    final controller = scrollView.controller;
    if (controller == null) {
      return Size(
        max(extendedSize.width, originSize.width),
        max(extendedSize.height, originSize.height),
      );
    }

    final scrollAxis = controller.position.axis;
    final maxScrollExtent = controller.position.maxScrollExtent;

    if (scrollAxis == Axis.horizontal) {
      final height = max(originSize.height, extendedSize.height);
      final width = max(maxScrollExtent + originSize.width, extendedSize.width);
      return Size(width, height);
    } else if (scrollAxis == Axis.vertical) {
      final height = max(maxScrollExtent + originSize.height, extendedSize.height);
      final width = max(originSize.width, extendedSize.width);
      return Size(width, height);
    }

    return originSize;
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
