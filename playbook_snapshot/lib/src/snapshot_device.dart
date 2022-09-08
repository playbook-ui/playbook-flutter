import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class SnapshotDevice {
  const SnapshotDevice({
    required this.name,
    required this.size,
    required this.platform,
  });

  final String name;
  final Size size;
  final TargetPlatform platform;

  static const iPhoneSE = SnapshotDevice(
    name: 'iPhoneSE',
    size: Size(320, 568),
    platform: TargetPlatform.iOS,
  );

  static const iPhone8 = SnapshotDevice(
    name: 'iPhone8',
    size: Size(375, 667),
    platform: TargetPlatform.iOS,
  );

  static const iPhone11 = SnapshotDevice(
    name: 'iPhone11',
    size: Size(414, 896),
    platform: TargetPlatform.iOS,
  );

  static const pixel4 = SnapshotDevice(
    name: 'pixel4',
    size: Size(411, 869),
    platform: TargetPlatform.android,
  );

  static const xperia = SnapshotDevice(
    name: 'xperia',
    size: Size(360, 640),
    platform: TargetPlatform.android,
  );
}
