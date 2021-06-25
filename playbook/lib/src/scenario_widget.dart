import 'package:flutter/material.dart';

import 'scenario.dart';

class ScenarioWidget extends StatelessWidget {
  const ScenarioWidget({required this.scenario});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: scenario.alignment,
      child: scenario.child,
    );
  }
}
