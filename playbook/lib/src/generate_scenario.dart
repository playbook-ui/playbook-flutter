import 'scenario_layout.dart';

class GenerateScenario {
  const GenerateScenario({
    this.title,
    this.layout = const ScenarioLayout.compressed(),
    this.scale = 0.3,
  });

  final String? title;
  final ScenarioLayout layout;
  final double scale;
}
