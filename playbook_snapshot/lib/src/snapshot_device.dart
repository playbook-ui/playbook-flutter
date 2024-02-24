import 'package:flutter/widgets.dart';

class SafeAreaInsets {
  const SafeAreaInsets({
    this.portrait = EdgeInsets.zero,
    this.landscape = EdgeInsets.zero,
  });

  final EdgeInsets portrait;
  final EdgeInsets landscape;
}

enum SnapshotDeviceOrientation {
  portrait,
  landscape,
}

class SnapshotDevice {
  const SnapshotDevice({
    required this.name,
    required Size size,
    SafeAreaInsets safeAreaInsets = const SafeAreaInsets(),
    this.textScaler,
    this.pixelRatio = 1,
    this.orientation = SnapshotDeviceOrientation.portrait,
    required this.platform,
  })  : _size = size,
        _safeAreaInsets = safeAreaInsets;

  final String name;
  final Size _size;
  final SafeAreaInsets _safeAreaInsets;
  final TextScaler? textScaler;
  final double pixelRatio;
  final SnapshotDeviceOrientation orientation;
  final TargetPlatform platform;

  Size get size {
    return switch (orientation) {
      SnapshotDeviceOrientation.portrait => _size,
      SnapshotDeviceOrientation.landscape => _size.flipped,
    };
  }

  EdgeInsets get safeAreaInsets {
    return switch (orientation) {
      SnapshotDeviceOrientation.portrait => _safeAreaInsets.portrait,
      SnapshotDeviceOrientation.landscape => _safeAreaInsets.landscape,
    };
  }

  SnapshotDevice removeSafeAreaInsets() {
    return copyWith(
      safeAreaInsets: const SafeAreaInsets(),
    );
  }

  SnapshotDevice call(SnapshotDeviceOrientation orientation) {
    return copyWith(
      orientation: orientation,
    );
  }

  SnapshotDevice copyWith({
    String? name,
    Size? size,
    SafeAreaInsets? safeAreaInsets,
    SnapshotDeviceOrientation? orientation,
    TargetPlatform? platform,
  }) {
    return SnapshotDevice(
      name: name ?? this.name,
      size: size ?? _size,
      safeAreaInsets: safeAreaInsets ?? _safeAreaInsets,
      orientation: orientation ?? this.orientation,
      platform: platform ?? this.platform,
    );
  }

  @Deprecated('Use iPhoneSE1st instead.')
  static const iPhoneSE = SnapshotDevice(
    name: 'iPhoneSE',
    size: Size(320, 568),
    platform: TargetPlatform.iOS,
  );

  static const iPhoneSE1st = SnapshotDevice(
    name: 'iPhoneSE1st',
    size: Size(320, 568),
    safeAreaInsets: SafeAreaInsets(
      portrait: EdgeInsets.fromLTRB(0, 20, 0, 0),
      landscape: EdgeInsets.fromLTRB(0, 20, 0, 0),
    ),
    platform: TargetPlatform.iOS,
  );

  @Deprecated('Use iPhoneSE2nd instead.')
  static const iPhone8 = SnapshotDevice(
    name: 'iPhone8',
    size: Size(375, 667),
    platform: TargetPlatform.iOS,
  );

  static const iPhoneSE2nd = SnapshotDevice(
    name: 'iPhoneSE2nd',
    size: Size(375, 667),
    safeAreaInsets: SafeAreaInsets(
      portrait: EdgeInsets.fromLTRB(0, 20, 0, 0),
    ),
    platform: TargetPlatform.iOS,
  );

  static const iPhone11 = SnapshotDevice(
    name: 'iPhone11',
    size: Size(414, 896),
    safeAreaInsets: SafeAreaInsets(
      portrait: EdgeInsets.fromLTRB(0, 48, 0, 34),
      landscape: EdgeInsets.fromLTRB(48, 0, 48, 21),
    ),
    platform: TargetPlatform.iOS,
  );

  static const iPhone15 = SnapshotDevice(
    name: 'iPhone15',
    size: Size(393, 852),
    safeAreaInsets: SafeAreaInsets(
      portrait: EdgeInsets.fromLTRB(0, 59, 0, 34),
      landscape: EdgeInsets.fromLTRB(59, 0, 59, 21),
    ),
    platform: TargetPlatform.iOS,
  );

  static const pixel4 = SnapshotDevice(
    name: 'pixel4',
    size: Size(411, 869),
    safeAreaInsets: SafeAreaInsets(
      portrait: EdgeInsets.fromLTRB(0, 24, 0, 0),
      landscape: EdgeInsets.fromLTRB(0, 24, 0, 0),
    ),
    platform: TargetPlatform.android,
  );

  static const pixel6 = SnapshotDevice(
    name: 'pixel6',
    size: Size(411, 914),
    safeAreaInsets: SafeAreaInsets(
      portrait: EdgeInsets.fromLTRB(0, 24, 0, 0),
      landscape: EdgeInsets.fromLTRB(0, 24, 0, 0),
    ),
    platform: TargetPlatform.android,
  );

  static const xperia = SnapshotDevice(
    name: 'xperia',
    size: Size(360, 640),
    safeAreaInsets: SafeAreaInsets(
      portrait: EdgeInsets.fromLTRB(0, 24, 0, 0),
      landscape: EdgeInsets.fromLTRB(0, 24, 0, 0),
    ),
    platform: TargetPlatform.android,
  );
}
