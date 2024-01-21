import 'package:flutter/material.dart';
import 'package:playbook/src/scenario.dart';

class ScenarioWidget extends StatelessWidget {
  const ScenarioWidget({super.key, required this.scenario});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: scenario.alignment,
      child: scenario.child,
    );
  }
}
