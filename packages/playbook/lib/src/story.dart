import 'package:playbook/src/scenario.dart';

class Story {
  const Story(
    this.title, {
    this.scenarios = const [],
  });

  final String title;
  final List<Scenario> scenarios;
}
