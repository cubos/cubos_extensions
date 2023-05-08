import 'context_extensions_test.dart' as context_extensions;
import 'datetime_extensions_test.dart' as datetime_extensions;
import 'duration_extensions_test.dart' as duration_extensions;
import 'list_extensions_test.dart' as list_extensions;
import 'number_extensions_test.dart' as number_extensions;
import 'object_extensions_test.dart' as object_extensions;
import 'string_extensions_test.dart' as string_extensions;

void main() {
  context_extensions.main();
  string_extensions.main();
  datetime_extensions.main();
  number_extensions.main();
  duration_extensions.main();
  list_extensions.main();
  object_extensions.main();
}
