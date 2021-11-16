import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

import '../main.dart';

Widget assetImage() => Image.asset(
      'assets/flutter.png',
      package: packageName,
    );

Story assetImageStory() {
  return Story('AssetImage', scenarios: [
    Scenario(
      'AssetImage',
      child: assetImage(),
    )
  ]);
}
