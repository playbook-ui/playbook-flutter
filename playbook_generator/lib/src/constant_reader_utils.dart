import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

/// Currently only for ScenarioLayout
String constantReaderToSource(
    ConstantReader reader, String Function(Reference) a) {
  if (reader.isString) {
    return '\'${reader.stringValue}\'';
  } else if (reader.isDouble) {
    return reader.doubleValue.toString();
  } else {
    final revivable = reader.revive();
    final constructor =
        '${revivable.source.fragment}${revivable.accessor.isEmpty ? '' : '.${revivable.accessor}'}';
    final url = 'package:${revivable.source.path.replaceFirst('lib/', '')}';
    final constructorRefer = a(refer(constructor, url));
    final parameters = revivable.positionalArguments
        .map((e) => constantReaderToSource(ConstantReader(e), a))
        .join(', ');
    return '$constructorRefer($parameters)';
  }
}
