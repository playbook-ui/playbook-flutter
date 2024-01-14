import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';

import 'snapshot_device.dart';

class SnapshotSupport {
  static const _maxTryResizeCount = 10;
  static const _maxSnapshotSize = 50000;

  static Future<void> startDevice(
    Widget target,
    WidgetTester tester,
    SnapshotDevice device,
  ) async {
    tester.view.devicePixelRatio = 1;
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
      var lastExtendedSize = Size(
        scenario.layout.compressedResizingTarget.needResizingWidth
            ? device.size.width
            : absoluteSize.width,
        scenario.layout.compressedResizingTarget.needResizingHeight
            ? device.size.height
            : absoluteSize.height,
      );
      var resize = 0;
      while (true) {
        final scrollables =
            find.byType(Scrollable).evaluate().map((e) => e.widget);
        if (scrollables.isEmpty) break;

        // To obtain the ScrollPosition,
        // search for ScrollableStates in the innermost widget of Scrollables,
        // regardless of whether Scrollables have a ScrollController or not.
        final scrollableStates = scrollables
            .map(
              (scrollable) => find
                  .descendant(
                    of: find.byWidget(scrollable),
                    matching: find.byWidgetPredicate((widget) => true),
                  )
                  .last
                  .evaluate()
                  .map((element) => Scrollable.maybeOf(element))
                  .firstWhere((element) => element != null, orElse: () => null),
            )
            .where((element) => element != null);

        var extendedSize = device.size;
        for (final scrollableState in scrollableStates) {
          extendedSize = _extendScrollableSnapshotSize(
            scrollableState: scrollableState!,
            currentExtendedSize: extendedSize,
            originSize: lastExtendedSize,
            resizingTarget: scenario.layout.compressedResizingTarget,
          );
        }
        if (extendedSize <= lastExtendedSize) break;
        lastExtendedSize = extendedSize;
        await _setSnapshotSize(tester, lastExtendedSize);
        resize++;
        if (resize >= _maxTryResizeCount) {
          throw StateError(
              'Try resizing too many times. Please try to set your scenario to have a fixed size.');
        }
        if (extendedSize.width >= _maxSnapshotSize ||
            extendedSize.height >= _maxSnapshotSize) {
          throw StateError(
              'Try resizing too large size $extendedSize. Please try to set your scenario to have a fixed size.');
        }
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
    for (var element in find.byType(Image).evaluate()) {
      final Image widget = element.widget as Image;
      final ImageProvider image = widget.image;
      await precacheImage(image, element);
      await tester.pumpAndSettle();
    }
  }

  static Future<void> _setSnapshotSize(WidgetTester tester, Size size) async {
    await tester.binding.setSurfaceSize(size);
    tester.view.physicalSize = size;
    await tester.pumpAndSettle();
  }

  static Size _extendScrollableSnapshotSize({
    required ScrollableState scrollableState,
    required Size currentExtendedSize,
    required Size originSize,
    required _CompressedResizingTarget resizingTarget,
  }) {
    ScrollPosition? position;
    try {
      position = scrollableState.position;
    } catch (_) {}
    if (position == null) {
      return Size(
        resizingTarget.needResizingWidth
            ? max(currentExtendedSize.width, originSize.width)
            : originSize.width,
        resizingTarget.needResizingHeight
            ? max(currentExtendedSize.height, originSize.height)
            : originSize.height,
      );
    }

    final scrollAxis = position.axis;
    final maxScrollExtent = position.maxScrollExtent;

    final Size newExtendedSize;
    switch (scrollAxis) {
      case Axis.horizontal:
        final height = max(originSize.height, currentExtendedSize.height);
        final width =
            max(maxScrollExtent + originSize.width, currentExtendedSize.width);
        newExtendedSize = Size(width, height);
        break;
      case Axis.vertical:
        final height = max(
            maxScrollExtent + originSize.height, currentExtendedSize.height);
        final width = max(originSize.width, currentExtendedSize.width);
        newExtendedSize = Size(width, height);
        break;
    }
    return Size(
      resizingTarget.needResizingWidth
          ? newExtendedSize.width
          : originSize.width,
      resizingTarget.needResizingHeight
          ? newExtendedSize.height
          : originSize.height,
    );
  }
}

extension on ScenarioLayout {
  ScenarioLayoutCompressed? _compressedLayout(ScenarioLayoutSizing layout) {
    return layout is ScenarioLayoutCompressed ? layout : null;
  }

  bool _needsCompressedLayoutResizing(ScenarioLayoutSizing layout) {
    return _compressedLayout(layout)?.needsScrollableResizing ?? false;
  }

  bool get needsResizing {
    return !(v is ScenarioLayoutFill && h is ScenarioLayoutFill);
  }

  bool get needsCompressedResizing {
    return _needsCompressedLayoutResizing(v) ||
        _needsCompressedLayoutResizing(h);
  }

  _CompressedResizingTarget get compressedResizingTarget {
    if (_needsCompressedLayoutResizing(v) &&
        _needsCompressedLayoutResizing(h)) {
      return _CompressedResizingTarget.both;
    } else if (_needsCompressedLayoutResizing(v)) {
      return _CompressedResizingTarget.vertical;
    } else if (_needsCompressedLayoutResizing(h)) {
      return _CompressedResizingTarget.horizontal;
    } else {
      throw StateError('No need compressed resizing.');
    }
  }

  double absoluteWidth(SnapshotDevice device) {
    switch (h.runtimeType) {
      case ScenarioLayoutFixed:
        return (h as ScenarioLayoutFixed).value;
      case ScenarioLayoutFill:
      case ScenarioLayoutCompressed:
        return device.size.width;
    }
    return device.size.width;
  }

  double absoluteHeight(SnapshotDevice device) {
    switch (v.runtimeType) {
      case ScenarioLayoutFixed:
        return (v as ScenarioLayoutFixed).value;
      case ScenarioLayoutFill:
      case ScenarioLayoutCompressed:
        return device.size.height;
    }
    return device.size.height;
  }
}

enum _CompressedResizingTarget {
  horizontal,
  vertical,
  both,
}

extension on _CompressedResizingTarget {
  bool get needResizingWidth =>
      this == _CompressedResizingTarget.both ||
      this == _CompressedResizingTarget.horizontal;

  bool get needResizingHeight =>
      this == _CompressedResizingTarget.both ||
      this == _CompressedResizingTarget.vertical;
}
