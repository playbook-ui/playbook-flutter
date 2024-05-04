import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:playbook_snapshot/src/pubspec_reader.dart';

class FontBuilder {
  static Future<void> loadFonts() async {
    await _loadFontManifest();
    await _loadFontFamily();
  }

  static Future<void> _loadFontAssets(
    List<dynamic> fonts,
    Future<ByteData> Function(String asset) loadData,
  ) async {
    for (final manifest in fonts) {
      final font = manifest as Map<String, dynamic>?;
      final fonts = font?['fonts'] as List<dynamic>? ?? [];
      final fontFamily = font?['family'] as String? ?? '';

      final fontLoader = FontLoader(fontFamily);
      for (final font in fonts) {
        final asset = (font as Map<String, dynamic>)['asset'] as String;
        fontLoader.addFont(loadData(asset));
      }
      await fontLoader.load();
    }
  }

  static Future<void> _loadFontManifest() async {
    final fonts = await rootBundle.loadStructuredData(
      'FontManifest.json',
      (string) => Future.value(json.decode(string) as List<dynamic>),
    );

    await _loadFontAssets(fonts, rootBundle.load);
  }

  static Future<void> _loadFontFamily() async {
    final playbook = PubspecReader.read('playbook_snapshot');
    final fonts = playbook?['fonts'] as List<dynamic>? ?? [];

    Future<ByteData> load(String asset) async {
      return File(asset).readAsBytesSync().buffer.asByteData();
    }

    await _loadFontAssets(fonts, load);
  }
}
