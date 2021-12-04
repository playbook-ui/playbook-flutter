import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

Story multipleHeroStoryForTest() {
  return Story('MultipleHeroStoryForTest', scenarios: [
    Scenario(
      'Hero1',
      child: _HeroTest(),
    ),
    Scenario(
      'Hero2',
      child: _HeroTest(),
    ),
    Scenario(
      'Hero3',
      child: _HeroTest(),
    ),
  ]);
}

class _HeroTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero_tag',
      child: const SizedBox(),
    );
  }
}
