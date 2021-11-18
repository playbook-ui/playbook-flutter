import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

const storyTitle = 'FooWidget';

Scenario foo1() {
  return Scenario('Hello', child: Container(color: Colors.blue));
}

Scenario foo2() {
  return Scenario(
    'World',
    alignment: Alignment.topRight,
    child: Center(
      child: Container(width: 200, height: 250, color: Colors.amber),
    ),
  );
}

@GenerateScenario(
  title: 'foo3foo3',
  layout: ScenarioLayout.sizing(
    ScenarioLayoutFixed(100),
    ScenarioLayoutFixed(200),
  ),
)
class Foo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.amber);
  }
}

@GenerateScenario(
  layout: ScenarioLayout.fixedH(
    300,
    crossAxisLayout: ScenarioLayoutFill(),
  ),
)
class $Foo4_Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.pink);
  }
}

@GenerateScenario(
  layout: ScenarioLayout.fixedV(
    500,
    crossAxisLayout: ScenarioLayoutFixed(200),
  ),
)
Widget $foo5() => Text('Foo 5');
