import 'package:component_catalog_app/page/page.dart';
import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

const storyTitle = 'HomePage';

@GenerateScenario()
Widget myPage() => HomePage(title: 'Home Page');
