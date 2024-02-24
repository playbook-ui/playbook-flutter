import 'package:flutter/widgets.dart';

class SafeArea {
  const SafeArea({
    this.portrait = EdgeInsets.zero,
    this.landscape = EdgeInsets.zero,
  });

  final EdgeInsets portrait;
  final EdgeInsets landscape;
}

enum Orientation {
  portrait,
  landscape,
}

class SnapshotDevice {
  const SnapshotDevice({
    required this.name,
    required Size size,
    SafeArea safeArea = const SafeArea(),
    this.textScaler,
    this.pixelRatio = 1,
    this.orientation = Orientation.portrait,
    required this.platform,
  })  : _size = size,
        _safeArea = safeArea;

  final String name;
  final Size _size;
  final SafeArea _safeArea;
  final TextScaler? textScaler;
  final double pixelRatio;
  final Orientation orientation;
  final TargetPlatform platform;

  Size get size {
    return switch (orientation) {
      Orientation.portrait => _size,
      Orientation.landscape => _size.flipped,
    };
  }

  EdgeInsets get safeArea {
    return switch (orientation) {
      Orientation.portrait => _safeArea.portrait,
      Orientation.landscape => _safeArea.landscape,
    };
  }

  SnapshotDevice removeSafeArea() {
    return copyWith(
      safeArea: const SafeArea(),
    );
  }

  SnapshotDevice toPortrait() {
    return copyWith(
      orientation: Orientation.portrait,
    );
  }

  SnapshotDevice toLandscape() {
    return copyWith(
      orientation: Orientation.landscape,
    );
  }

  SnapshotDevice copyWith({
    String? name,
    Size? size,
    SafeArea? safeArea,
    Orientation? orientation,
    TargetPlatform? platform,
  }) {
    return SnapshotDevice(
      name: name ?? this.name,
      size: size ?? _size,
      safeArea: safeArea ?? _safeArea,
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
    safeArea: SafeArea(
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
    safeArea: SafeArea(
      portrait: EdgeInsets.fromLTRB(0, 20, 0, 0),
    ),
    platform: TargetPlatform.iOS,
  );

  static const iPhone11 = SnapshotDevice(
    name: 'iPhone11',
    size: Size(414, 896),
    safeArea: SafeArea(
      portrait: EdgeInsets.fromLTRB(0, 48, 0, 34),
      landscape: EdgeInsets.fromLTRB(48, 0, 48, 21),
    ),
    platform: TargetPlatform.iOS,
  );

  static const iPhone15 = SnapshotDevice(
    name: 'iPhone15',
    size: Size(393, 852),
    safeArea: SafeArea(
      portrait: EdgeInsets.fromLTRB(0, 59, 0, 34),
      landscape: EdgeInsets.fromLTRB(59, 0, 59, 21),
    ),
    platform: TargetPlatform.iOS,
  );

  static const pixel4 = SnapshotDevice(
    name: 'pixel4',
    size: Size(411, 869),
    safeArea: SafeArea(
      portrait: EdgeInsets.fromLTRB(0, 24, 0, 0),
      landscape: EdgeInsets.fromLTRB(0, 24, 0, 0),
    ),
    platform: TargetPlatform.android,
  );

  static const pixel6 = SnapshotDevice(
    name: 'pixel6',
    size: Size(411, 914),
    safeArea: SafeArea(
      portrait: EdgeInsets.fromLTRB(0, 24, 0, 0),
      landscape: EdgeInsets.fromLTRB(0, 24, 0, 0),
    ),
    platform: TargetPlatform.android,
  );

  static const xperia = SnapshotDevice(
    name: 'xperia',
    size: Size(360, 640),
    safeArea: SafeArea(
      portrait: EdgeInsets.fromLTRB(0, 24, 0, 0),
      landscape: EdgeInsets.fromLTRB(0, 24, 0, 0),
    ),
    platform: TargetPlatform.android,
  );
}
