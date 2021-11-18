import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

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

class Foo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.amber);
  }
}

class Foo4_Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.pink);
  }
}

Widget foo5() => Text('Foo 5');

Story fooWidgetStory() {
  return Story('FooWidget', scenarios: [
    foo1(),
    foo2(),
    Scenario(
      'foo3foo3',
      layout: ScenarioLayout.sizing(
        ScenarioLayoutFixed(
          100.0,
        ),
        ScenarioLayoutFixed(
          200.0,
        ),
      ),
      child: Foo3(),
    ),
    Scenario(
      'Foo4 Bar',
      layout: ScenarioLayout.fixedH(
        300.0,
        crossAxisLayout: ScenarioLayoutFill(),
      ),
      child: Foo4_Bar(),
    ),
    Scenario(
      'foo5',
      layout: ScenarioLayout.fixedV(
        500.0,
        crossAxisLayout: ScenarioLayoutFixed(
          200.0,
        ),
      ),
      child: foo5(),
    ),
  ]);
}
