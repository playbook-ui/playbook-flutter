import 'package:flutter/material.dart';

import 'scenario_layout.dart';

class Scenario {
  const Scenario(
    this.title, {
    this.layout = const ScenarioLayout.compressed(),
    this.scale = 0.3,
    this.alignment = Alignment.center,
    required this.child,
  });

  final String title;
  final ScenarioLayout layout;
  final double scale;
  final AlignmentGeometry alignment;
  final Widget child;
}
