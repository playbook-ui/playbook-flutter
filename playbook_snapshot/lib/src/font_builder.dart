import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

class FontBuilder {
  static Future<void> loadFonts() async {
    await _loadFontManifest();
    await _loadFontFamily();
  }

  static Future<void> _loadFontManifest() async {
    final fontManifest = await rootBundle.loadStructuredData(
      'FontManifest.json',
      (string) => Future.value(json.decode(string) as List<dynamic>),
    );

    for (final manifest in fontManifest) {
      final font = manifest as Map<String, dynamic>?;
      final fonts = font?['fonts'] as List<dynamic>? ?? [];
      final fontFamily = font?['family'] as String? ?? '';

      final fontLoader = FontLoader(fontFamily);
      for (final font in fonts) {
        final asset = (font as Map<String, dynamic>)['asset'] as String;
        fontLoader.addFont(rootBundle.load(asset));
      }
      await fontLoader.load();
    }
  }

  static Future<void> _loadFontFamily() async {
    final yamlString = File('pubspec.yaml').readAsStringSync();
    final yaml = loadYaml(yamlString) as YamlMap?;
    final playbookSnapshot = yaml?['playbook_snapshot'] as YamlMap?;
    final snapshotFonts = playbookSnapshot?['fonts'] as YamlList? ?? [];

    for (final manifest in snapshotFonts) {
      final font = manifest as YamlMap?;
      final fonts = font?['fonts'] as YamlList? ?? [];
      final fontFamily = font?['family'] as String? ?? '';

      final fontLoader = FontLoader(fontFamily);
      for (final font in fonts) {
        final asset = (font as YamlMap)['asset'] as String;
        final assetData = File(asset).readAsBytesSync();
        fontLoader.addFont(Future.value(ByteData.view(assetData.buffer)));
      }

      await fontLoader.load();
    }
  }
}
