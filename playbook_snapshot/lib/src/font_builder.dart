import 'dart:async';
import 'dart:io';

import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform/platform.dart';
import 'package:yaml/yaml.dart';

class FontBuilder {
  static Future<void> loadFonts() async {
    await _loadFontFamily();
    await _loadMaterialIcons();
  }

  static Future<void> _loadFontFamily() async {
    final yamlString = await File('pubspec.yaml').readAsString();
    final yaml = loadYaml(yamlString) as YamlMap;
    final flutter = yaml['flutter'] as YamlMap?;
    final playbookSnapshot = yaml['playbook_snapshot'] as YamlMap?;
    final flutterFonts = flutter?['fonts'] as YamlList?;
    final snapshotFonts = playbookSnapshot?['fonts'] as YamlList?;
    final fonts = [...?flutterFonts, ...?snapshotFonts];

    if (fonts.isEmpty) {
      return;
    }

    for (final font in fonts) {
      final fontFamily = font as YamlMap;
      final loader = FontLoader(fontFamily['family'].toString());
      final fontList = (font['fonts'] as YamlList?)?.map((e) => e as YamlMap);

      for (final configurations in [...?fontList]) {
        final assetFile = File('${configurations['asset']}');
        final fontData = await assetFile.readAsBytes();
        loader.addFont(Future.value(ByteData.view(fontData.buffer)));
      }

      await loader.load();
    }
  }

  static Future<void> _loadMaterialIcons() async {
    const fs = LocalFileSystem();
    const platform = LocalPlatform();

    final flutterRoot = fs.directory(platform.environment['FLUTTER_ROOT']);

    final iconFont = flutterRoot.childFile(
      fs.path.join(
        'bin',
        'cache',
        'artifacts',
        'material_fonts',
        'MaterialIcons-Regular.otf',
      ),
    );

    final bytes = Future.value(iconFont.readAsBytesSync().buffer.asByteData());

    await (FontLoader('MaterialIcons')..addFont(bytes)).load();
  }
}
