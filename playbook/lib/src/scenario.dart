import 'package:flutter/material.dart';

import 'scenario_layout.dart';

class Scenario {
  const Scenario(
    this.title, {
    required this.layout,
    required this.child,
    this.scale = 0.3,
    this.alignment = Alignment.center,
  });

  final String title;
  final ScenarioLayout layout;
  final Widget child;
  final double scale;
  final AlignmentGeometry alignment;
}
