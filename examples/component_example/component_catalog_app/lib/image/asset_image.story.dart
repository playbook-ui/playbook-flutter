import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

const storyTitle = 'AssetImage';

@GenerateScenario()
Widget $AssetImage() => Image.asset(
      'assets/flutter.png',
      package: packageName,
    );
