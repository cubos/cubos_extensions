abstract class RubikRegExps {
  static final RegExp digitsOnlyRegex = RegExp(r'[^\d]');
  static final RegExp digitsOnlyWhiteSpaceRegex = RegExp(r'[^\d|^\d ]');

  static final RegExp withoutDigitsRegex = RegExp(r'\d+');
  static final RegExp withoutDigitsRegexSpecialCharacter = RegExp(
    r'[^\w\s]|[\d]+',
  );
  static final RegExp withoutLettersOrDigitsRegex = RegExp(r'[a-zA-Z0-9]');

  static final RegExp contaisUppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp contaisLowercaseRegex = RegExp(r'[a-z]');
  static final RegExp contaisLetterRegex = RegExp(r'[a-z, A-Z]');
  static final RegExp contaisDigitsRegex = RegExp(r'[0-9]');
  static final RegExp contaisSpecialCharactersRegex = RegExp(
    r'[!@#$%^&*(),.?":{}|<>-_+=]',
  );
  static final RegExp contaisRepetitionRegex = RegExp(r'(\w)\1+');

  static final RegExp dotAndCommaRegex = RegExp(r'[.,]');
  static final RegExp dayAndMonthRegex = RegExp(r'(dd|mmm|MMM|yyyy)');
  static final RegExp dateRegex = RegExp(
    r'^(\d{2}-\d{2}-\d{4}|\d{4}-\d{2}-\d{2}|\d{2}/\d{2}/\d{4}|\d{4}/\d{2}/\d{2})',
  );
  static final RegExp partsDurationRegex = RegExp(
    r'^(\d+):(\d+):(\d+)(?:\.(\d{1,3})(\d{1,3})?)?$',
  );

  static final RegExp cpfSpecialCharactersRegex = RegExp(r'[.-]');
  static final RegExp cnpjSpecialCharactersRegex = RegExp(r'[./-]');
  static final RegExp cpfRegex = RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$');
  static final RegExp cnpjRegex = RegExp(
    r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$',
  );

  static final RegExp randomPixKey = RegExp(
    r'^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$',
  );
}
