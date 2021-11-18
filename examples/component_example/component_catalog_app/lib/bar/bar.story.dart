import 'package:component/component.dart';
import 'package:playbook/playbook.dart';

const storyTitle = 'Sample Widget';

Scenario twoLineText() {
  return Scenario(
    'TwoLine',
    child: BarWidget(text: 'TextTextText\nTextText'),
  );
}

Scenario emptyText() {
  return Scenario('Empty', child: BarWidget(text: ''));
}

List<Scenario> variousText() {
  return ['Text 1', 'Text2']
      .map(
        (e) => Scenario(e, child: BarWidget(text: e)),
      )
      .toList();
}
