import 'package:flutter/widgets.dart';
import 'package:generator_app/scrollable/scrollable.dart';
import 'package:playbook/playbook.dart';

const storyTitle = 'scrollableStory';

@GenerateScenario(title: 'Primary Scrollable')
Widget primary() => scrollable(primary: true);

@GenerateScenario(title: 'Not Primary Scrollable')
Widget notPrimary() => scrollable(primary: false);
