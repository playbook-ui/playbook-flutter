import 'package:flutter/material.dart';

import 'scenario.dart';
import 'scenario_layout.dart';

class ScenarioParameter {
  const ScenarioParameter(
    this.title, {
    this.layout = const ScenarioLayout.compressed(),
    this.scale = 0.3,
    this.alignment = Alignment.center,
  });

  final String title;
  final ScenarioLayout layout;
  final double scale;
  final AlignmentGeometry alignment;

  Scenario create(Widget child) {
    return Scenario(
      title,
      child: child,
      layout: layout,
      scale: scale,
      alignment: alignment,
    );
  }
}
