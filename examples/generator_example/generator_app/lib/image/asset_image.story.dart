import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

import '../main.dart';

const storyTitle = 'AssetImage';

@GenerateScenario()
Widget $AssetImage() => Image.asset(
      'assets/flutter.png',
      package: packageName,
    );

@GenerateScenario()
Widget $MaterialIcon() => Icon(Icons.access_alarm);

@GenerateScenario()
Widget $CupertinoIcon() => Icon(CupertinoIcons.alarm);
