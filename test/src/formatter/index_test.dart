import 'inputs/rubik_cnpj_input_formatter_test.dart' as cnpj_formatter_test;
import 'inputs/rubik_cpf_cnpj_input_formatter_test.dart' as cpf_cnpj_test;
import 'inputs/rubik_cpf_input_formatter_test.dart' as cpf_formatter_test;
import 'inputs/rubik_money_input_formatter_test.dart' as money_formatter_test;
import 'rubik_formatter_base_test.dart' as rubik_formatter_base_test;

void main() {
  money_formatter_test.main();
  rubik_formatter_base_test.main();
  cpf_formatter_test.main();
  cnpj_formatter_test.main();
  cpf_cnpj_test.main();
}
