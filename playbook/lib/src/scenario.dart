import 'package:flutter/material.dart';
import 'package:playbook_meta/playbook_meta.dart';

class Scenario {
  const Scenario(
    this.title, {
    required this.child,
    this.layout = const ScenarioLayout.compressed(),
    this.scale = 0.3,
    this.alignment = Alignment.center,
  });

  factory Scenario.fromParameter(
    ScenarioParameter param, {
    required Widget child,
  }) {
    return Scenario(
      param.title,
      child: child,
      layout: param.layout,
      scale: param.scale,
      alignment: Alignment(param.alignment.x, param.alignment.y),
    );
  }

  final String title;
  final ScenarioLayout layout;
  final Widget child;
  final double scale;
  final AlignmentGeometry alignment;
}
