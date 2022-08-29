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
}
