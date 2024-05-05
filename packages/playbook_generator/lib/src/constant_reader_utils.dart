import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

/// Currently only for ScenarioLayout
String constantReaderToSource(
  ConstantReader reader,
  String Function(Reference) allocator,
) {
  if (reader.isString) {
    return "'${reader.stringValue}'";
  } else if (reader.isDouble) {
    return reader.doubleValue.toString();
  } else {
    final revivable = reader.revive();
    final accessor = revivable.accessor.let((it) => it.isEmpty ? '' : '.$it');
    final constructor = '${revivable.source.fragment}$accessor';
    final url = 'package:${revivable.source.path.replaceFirst('lib/', '')}';
    final constructorRefer = allocator(refer(constructor, url));
    final positions = revivable.positionalArguments
        .map(ConstantReader.new)
        .map((e) => constantReaderToSource(e, allocator))
        .join(', ');
    final nameds = revivable.namedArguments.entries
        .map((e) => MapEntry(e.key, ConstantReader(e.value)))
        .map((e) => '${e.key}: ${constantReaderToSource(e.value, allocator)}')
        .join(', ');
    final positionText = positions.let((it) => it.isEmpty ? '' : '$it,');
    final namedText = nameds.let((it) => it.isEmpty ? '' : '$it,');
    return '$constructorRefer($positionText$namedText)';
  }
}

extension<T> on T {
  V let<V>(V Function(T it) transform) => transform(this);
}
