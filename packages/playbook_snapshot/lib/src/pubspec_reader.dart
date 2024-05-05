import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

class PubspecReader {
  static Map<String, dynamic>? read(String key) {
    final yamlString = File('pubspec.yaml').readAsStringSync();
    final yaml = loadYaml(yamlString);
    final pubspec = json.decode(json.encode(yaml)) as Map<String, dynamic>?;
    return pubspec?[key] as Map<String, dynamic>?;
  }
}
