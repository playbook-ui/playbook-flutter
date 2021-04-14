import 'scenario_alignment.dart';
import 'scenario_layout.dart';

class ScenarioParameter {
  const ScenarioParameter(
    this.title, {
    this.layout = const ScenarioLayout.compressed(),
    this.scale = 0.3,
    this.alignment = ScenarioAlignment.center,
  });

  final String title;
  final ScenarioLayout layout;
  final double scale;
  final ScenarioAlignment alignment;
}
