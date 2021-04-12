import 'scenario.dart';
import 'story.dart';
import 'test_tool.dart';

class Playbook {
  Playbook({
    List<Story>? stories,
  }) : stories = stories ?? [];

  final List<Story> stories;

  void addScenariosOf(String title, {required List<Scenario> scenarios}) {
    stories.add(Story(title, scenarios: scenarios));
  }

  Future<void> run(TestTool test, PlaybookBuilder builder) async {
    await test.run(this, builder);
  }
}
