import 'cpf_cnpj_validator/rubik_cnpj_validator_test.dart' as cnpj_validator;
import 'cpf_cnpj_validator/rubik_cpf_validator_test.dart' as cpf_validator;
import 'types/rubik_string_validations_test.dart' as string_validations;
import 'types/rubik_validator_type_test.dart' as valdiator_types;

void main() {
  cpf_validator.main();
  cnpj_validator.main();

  valdiator_types.main();
  string_validations.main();
}
