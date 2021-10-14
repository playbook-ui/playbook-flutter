import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dartx/dartx.dart';

/// Currently only for ScenarioLayout
String constantReaderToSource(
  ConstantReader reader,
  String Function(Reference) allocator,
) {
  if (reader.isString) {
    return '\'${reader.stringValue}\'';
  } else if (reader.isDouble) {
    return reader.doubleValue.toString();
  } else {
    final revivable = reader.revive();
    final constructor =
        '${revivable.source.fragment}${revivable.accessor.isEmpty ? '' : '.${revivable.accessor}'}';
    final url = 'package:${revivable.source.path.replaceFirst('lib/', '')}';
    final constructorRefer = allocator(refer(constructor, url));
    final positionParameters = revivable.positionalArguments
        .map((e) => constantReaderToSource(ConstantReader(e), allocator))
        .join(', ');
    final namedParameters = revivable.namedArguments.entries
        .map((e) => '${e.key}: ${constantReaderToSource(ConstantReader(e.value), allocator)}')
        .join(', ');
    return '$constructorRefer(' +
        (positionParameters.isNotEmpty ? '$positionParameters,' : '') +
        (namedParameters.isNotEmpty ? '$namedParameters,' : '') +
        ')';
  }
}
