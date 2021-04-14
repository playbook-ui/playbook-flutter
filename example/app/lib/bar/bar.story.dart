import 'package:app/bar/bar.dart';
import 'package:playbook/playbook.dart';

const storyTitle = 'BarWidget';

Scenario twoLineText() {
  return Scenario(
    'TwoLine',
    child: BarWidget(text: 'TextTextText\nTextText'),
  );
}

Scenario emptyText() {
  return Scenario('Empty', child: BarWidget(text: ''));
}
