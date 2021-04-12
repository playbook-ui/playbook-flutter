import 'package:flutter/rendering.dart';

enum SnapshotDevice {
  iPhoneSE,
  iPhone8,
  iPhone11,
  pixcel4,
  xperia,
}

extension SnapshotDeviceExt on SnapshotDevice {
  Size get size {
    switch (this) {
      case SnapshotDevice.iPhoneSE:
        return const Size(320, 568);
      case SnapshotDevice.iPhone8:
        return const Size(375, 667);
      case SnapshotDevice.iPhone11:
        return const Size(414, 896);
      case SnapshotDevice.pixcel4:
        return const Size(411, 869);
      case SnapshotDevice.xperia:
        return const Size(360, 640);
    }
  }

  String get name {
    return toString().split('.').last;
  }
}
