import 'package:playbook/src/scenario_layout.dart';

// TODO: alignment
class GenerateScenario {
  const GenerateScenario({
    this.title,
    this.layout = const ScenarioLayout.compressed(),
  });

  final String? title;
  final ScenarioLayout layout;
}
