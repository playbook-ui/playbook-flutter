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
