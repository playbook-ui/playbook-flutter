import 'package:simple_app/scrollable/scrollable.dart';
import 'package:playbook/playbook.dart';

Story scrollableStory() {
  return Story('Scrollable', scenarios: [
    Scenario(
      'Primary Scrollable',
      child: scrollable(primary: true),
    ),
    Scenario(
      'Not Primary Scrollable',
      child: scrollable(primary: false),
    )
  ]);
}
