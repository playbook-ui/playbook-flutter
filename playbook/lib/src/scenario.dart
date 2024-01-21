import 'package:flutter/material.dart';
import 'package:playbook/src/scenario_layout.dart';

class Scenario {
  const Scenario(
    this.title, {
    this.layout = const ScenarioLayout.compressed(),
    this.alignment = Alignment.center,
    required this.child,
  });

  final String title;
  final ScenarioLayout layout;
  final AlignmentGeometry alignment;
  final Widget child;
}
