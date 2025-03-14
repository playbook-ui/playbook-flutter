import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_snapshot/src/snapshot_device.dart';

class SnapshotSupport {
  static const _maxTryResizeCount = 10;
  static const _maxSnapshotSize = 50000;

  static Future<void> startDevice(
    Widget target,
    WidgetTester tester,
    SnapshotDevice device,
  ) async {
    tester.view.devicePixelRatio = device.pixelRatio;
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
      // To solve this, we repeatedly calculate size and update size until
      // we can get a stable value.
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
                  .map(Scrollable.maybeOf)
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
            // ignore: lines_longer_than_80_chars
            'Try resizing too many times. Please try to set your scenario to have a fixed size.',
          );
        }
        if (extendedSize.width >= _maxSnapshotSize ||
            extendedSize.height >= _maxSnapshotSize) {
          throw StateError(
            // ignore: lines_longer_than_80_chars
            'Try resizing too large size $extendedSize. Please try to set your scenario to have a fixed size.',
          );
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
    for (final element in find.byType(Image).evaluate()) {
      final widget = element.widget as Image;
      final image = widget.image;
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
      case Axis.vertical:
        final height = max(
          maxScrollExtent + originSize.height,
          currentExtendedSize.height,
        );
        final width = max(originSize.width, currentExtendedSize.width);
        newExtendedSize = Size(width, height);
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
  bool get needsResizing {
    return !(v is ScenarioLayoutFill && h is ScenarioLayoutFill);
  }

  bool get needsCompressedResizing {
    return v is ScenarioLayoutCompressed || h is ScenarioLayoutCompressed;
  }

  _CompressedResizingTarget get compressedResizingTarget {
    if (v is ScenarioLayoutCompressed && h is ScenarioLayoutCompressed) {
      return _CompressedResizingTarget.both;
    } else if (v is ScenarioLayoutCompressed) {
      return _CompressedResizingTarget.vertical;
    } else if (h is ScenarioLayoutCompressed) {
      return _CompressedResizingTarget.horizontal;
    } else {
      throw StateError('No need compressed resizing.');
    }
  }

  double absoluteWidth(SnapshotDevice device) {
    switch (h.runtimeType) {
      case ScenarioLayoutFixed _:
        return (h as ScenarioLayoutFixed).value;
      case ScenarioLayoutFill _:
        return device.size.width;
      case ScenarioLayoutCompressed _:
        return 0;
    }
    return device.size.width;
  }

  double absoluteHeight(SnapshotDevice device) {
    switch (v.runtimeType) {
      case ScenarioLayoutFixed _:
        return (v as ScenarioLayoutFixed).value;
      case ScenarioLayoutFill _:
        return device.size.height;
      case ScenarioLayoutCompressed _:
        return 0;
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
