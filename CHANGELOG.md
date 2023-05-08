# Changelog

## 1.0.0 (2023-05-03)

- Created the `RubikValidatorType` abstract class representing a validator type
that can be used to validate and transform input values for a field.

    ```dart
    class MyValidator extends RubikValidatorType {}

    final validator = MyValidator()
    .require(message: 'This field is required')
    .transform<String, int>((value) => int.tryParse(value))
    .types([int, double], message: 'This field must be a number')
    .addValidate((value) => value > 0 ? null : 'This field must be positive');

    print(validator.validate('42.0')); // null
    print(validator.validate('-1')); // returns 'This field must be positive'
    ```

- Created the `RubikString Validations` or `String` class containing methods for string validation, for example:

    ```dart
    RString().minLength(8).validate('rubik'); // returns 'The minimum length is 8'
    RString().maxLength(4).validate('rubik'); // returns 'The maximum length is 4'
    RString().length(4).validate('rubik'); // returns 'The length must be 4'

    RString().cpf().validate('12345678901'); // returns 'Invalid CPF'
    RString().cnpj().validate('12345678901234'); // returns 'Invalid CNPJ'
    RString().cpfOrCnpj().validate('12345678901'); // returns 'Invalid CPF or CNPJ'

    RString().email().validate(''); // returns 'Invalid email'
    RString().url().validate(''); // returns 'Invalid URL'
    RString().uuid().validate(''); // returns 'Invalid UUID'

    RString().creditCard().validate(''); // returns 'Invalid credit card'
    RString().randomPixKey().validate(''); // returns 'Invalid random pix key'
    RString().match(r'^[a-zA-Z0-9]+$').validate(''); // returns 'Invalid match'

    RString().includes('abc').validate(''); // returns 'Invalid includes'
    RString().startsWith('abc').validate(''); // returns 'Invalid starts with'
    RString().endsWith('abc').validate(''); // returns 'Invalid ends with'
    RString().equals('abc').validate(''); // returns 'Invalid equals'

    RString().ip().validate(''); // returns 'Invalid IP'
    RString().date().validate('') // returns 'Invalid date'

    RString().uppercase(2).validate('') // returns 'Invalid uppercase'
    RString().lowercase(2).validate('') // returns 'Invalid lowercase'
    RString().digits(3).validate('') // returns 'Invalid digits'
    RString().specialCharacters().validate('') // returns 'Invalid special characters'

    RString().repetition().validate('') // returns 'Invalid repetition'
    RString().digitSequence().validate('') // returns 'Invalid digit sequence'

    RString().toUpperCase().uppercase().validate('abc') // returns null
    RString().toLowerCase().lowercase().validate('ABC') // returns null

    RString().toUpperCase().uppercase().validate('abc') // returns null
    RString().toLowerCase().lowercase().validate('ABC') // returns null

    RString().toUpperCase().uppercase().parse('abc') // return ABC
    RString().toLowerCase().lowercase().parse('ABC') // return abc
    ```

## 1.0.0 (2023-04-12)

- Created the `RubikNullObjectExtension` extension in the `object_extension.dart` file, containing methods to facilitate the manipulation of objects/null, for example:

    ```dart
    null.isNull // true
    null.isNotNull  // false
    1.isInstanceOf<int>() // true
    1.isInstanceOf<String>() // false

    'true'.castAs<bool>();
    '10:24:45'.castAs<Duration>(); // Duration(hours: 10, minutes: 24, seconds: 45);

    var called = false;
    null.ifNotNull(() => called = true); // called = false
    1.ifNotNullThen((it) => called = true) // called = true
    1.ifNotNullThen<int, String>((it) => 'int: $it') // int: 1

    1.isNotNullOrEmpty // true
    'Any'.className // String
    ```

## 0.0.9 (2023-04-04)

- Created the `RubikListExtensions` extension in the `list_extensions.dart` file, containing methods to facilitate list manipulation, for example:

    ```dart
    [1, 1, 1, 2, 3, 4, 5, 5, 9, 10].removeDuplicates; // [1, 2, 3, 4, 5, 9, 10]
    [1, 2, 3, 4, 5].addWhere(6, (element) => element > 5); // [1, 2, 3, 4, 5, 6]
    [1, 2, 3, 4, 5].groupListBy<int>((it) => it.isOdd ? 'odd' : 'even') // {odd: [1, 3, 5], even: [2, 4]}

    [1, 2, 3, 4, 5].isUnique; // true
    [1, 2, 3, 4, 5].isNotUnique; // false

    [1680100974265, 1679582574265].list.toDuration(); // [Duration: 20 years, 4 months, 1 day, Duration: 20 years, 3 months, 1 day]
    ['2023-05-01', '2023-04-01'].toDateTime; // [DateTime:2023-05-01, DateTime:2023-04-01]
    [1.0, 2.0, 3.0, 4.0, 5.0].toIntegers; // [1, 2, 3, 4, 5]
    [1, 2, 3, 4, 5].toDoubles; // [1.0, 2.0, 3.0, 4.0, 5.0]

    [1, 2, 3, 4, 5].sum // 15

    final list = [1, 2, 3, 4, 5];
    list.replace(1, 10); // [10, 2, 3, 4, 5]
    list.replace(1, 10, start: 1); // [10, 2, 3, 4, 5]
    list.replace(1, 10, start: 1, end: 3); // [10, 2, 3, 4, 5]

    [1, 2, 3, 4, 5].findMax((e) => e * 2); // 10
    [1, 2, 3, 4, 5].findMin((e) => e * 2); // 2

    [1, 2, 3, 4, 5, 1, 2, 3, 4, 5].countOccurrences(); // {1: 2, 2: 2, 3: 2, 4: 2, 5: 2}
    [1, 2, 3, 4, 5, 1, 2, 3, 4, 5].countOccurrences(1); // 2

    [1, 2, 3, 4, 5].average; // 3
    [1, 2, 3, 4, 5].rotate(2); // [3, 4, 5, 1, 2]
    ```

## 0.0.6 (2023-03-31)

- Created the `RubikDurationExtensions` extension in the `durations_extensions.dart` file, containing methods to facilitate the manipulation of durations, for example:

    ```dart
    final duration = Duration(days: 10, hours: 10, minutes: 10, seconds: 10);

    duration.dayStr() // returns '10'
    duration.hourStr() // returns '10'
    duration.minuteStr() // returns '10'
    duration.secondStr() // returns '10'

    duration.addHours(2) // returns  Duration(..., hours: 12, ...)
    duration.addMinutes(2) // returns  Duration(..., minutes: 12, ...)
    duration.addSeconds(2) // returns  Duration(..., seconds: 12, ...)
    duration.add(hours: 2, seconds: 4) // returns Duration(hours: 2, seconds: 14)

    duration.subtractHours(2) // returns Duration(hours: 8)
    duration.subtractMinutes(2) // returns Duration(minutes: 8)
    duration.subtractSeconds(2) // returns Duration(seconds: 8)
    duration.subtract(hours: 2, seconds: 4) // returns Duration(hours: 1, seconds: 6)

    Duration(days: 90).toNumberOfWeeks() // returns 12
    Duration(days: 90).toNumberOfMonths() // returns 3
    Duration(days: 3650).toNumberOfYears() // returns 10

    duration.daysWithSuffix() // returns '10 d'
    duration.daysWithSuffix(useShortSuffix: false) // returns '10 dias'
    duration.hoursWithSuffix() // returns '10 h'
    duration.hoursWithSuffix(useShortSuffix: false) // returns '10 horas'
    duration.minutesWithSuffix() // returns '10min'
    duration.minutesWithSuffix(useShortSuffix: false) // returns '10minutos'
    duration.secondsWithSuffix() // returns '10 s'
    duration.secondsWithSuffix(useShortSuffix: false) // returns '10 segundos'

    duration.toTimeStr() // returns '10d 10h 10min 10s'
    duration.toTimeStr(useShortSuffix: false) // returns '10dias 10horas 10minutos 10segundos'

    final now = DateTime.now(); // 2023-03-31
    duration.toDateTime() // returns  DateTime(2023, 03, 21, 10, 10, 10)
    ```

## 0.0.5 (2023-03-21)

- Created the `RubikDatetimeExtensions` extension in the `datetime_extensions.dart` file, containing methods to facilitate the manipulation of dates, for example:

    ```dart
    final date = DateTime(2023, 03, 13, 15, 30, 45);

    date.dayStr // returns '13'
    date.monthStr // returns '03'   
    date.yearStr // returns '2023'
    date.hourStr // returns '15'
    date.minuteStr // returns '30'
    date.secondStr // returns '45'
    
    date.toDateTimeStr // returns '13/03/2023'
    date.toIsoStr // returns '2023-03-13'

    date.subtractYears(3) // returns DateTime(2020, 03, 12)
    date.subtractDays(3) // returns DateTime(2023, 03, 10)
    date.subtractMonths(1) // returns DateTime(2023, 02, 13)
    date.subtractHours(2) // returns DateTime(2023, 03, 13, 13)
    date.subtractDate(years: 3, months: 2, days: 1) // returns DateTime(2020, 01, 12)
    
    date.toList() // returns [2023, 03, 13, 15, 30, 45]
    date.toList(reverse: true) // returns [13, 03, 2023, 15, 30, 45]
    
    date.toTimeStr() // returns '15:30'
    date.toTimeStr(format: RubikTimeFormat.hhmm) // returns '03:30'
    date.toTimeStr(format: RubikTimeFormat.hhmmss24H) // returns '15:30:45'
    
    date.toDateAndTimeStr(separator: ' às ') // returns '13/03/2023 às 15:30'
    date.toDateAndTimeStr(format: RubikTimeFormat.hhmmss24H) // returns '13/03/2023 - 15:30:45'
    date.toTimeAndDateStr(separator: ' às ') // returns '15:30 às 13/03/2023'
    date.toTimeAndDateStr(format: RubikTimeFormat.hhmmss24H) // returns '15:30:02 - 13/03/2023'

    date.toWeekdayStr() // returns 'Terça'
    date.toWeekdayStr(useAbbreviation: true) // returns 'Terça-feira'
    date.toMonthNameStr() // returns 'Março'
    date.toMonthNameStr(useShortName: true) // returns 'Mar'

    date.toFullDateTimeStr() // returns '13/03'
    date.isBetween(DateTime(2023, 03, 13), DateTime(2023, 03, 24)) // returns true
    ```

## 0.0.4 (2023-03-13)

- Created the `rubik_strings.dart` file, containing all the project strings. For example:

    ```dart
    RubikStrings.defaultLocale // returns 'pt_BR'
    RubikStrings.defaultCurrencySymbol // returns 'R\$'

    RubikStrings.weekdaysByLocale() // returns ['Segunda', 'Terça', 'Quarta', ... ]
    RubikStrings.weekdaysByLocale(locale: 'en') // returns ['Monday', 'Tuesday', 'Wednesday', ... ]

    RubikStrings.monthsByLocale() // returns ['Janeiro', 'Fevereiro', 'Março', ... ]
    RubikStrings.monthsByLocale(locale: 'en') // returns ['January', 'February', 'March', ... ]
    ```

## 0.0.3 (2023-03-13)

- Created the `RubikNumberExtension` extension in the `number_extensions.dart` file, containing methods to facilitate the manipulation of numbers, for example:

    ```dart
    10.isInteger // returns true
    10.45.isDouble // returns true
    10.34.toCents // returns 1034 
    1034.toReal // returns 10.34
    1000.toRealWithTwoDecimals() // returns 10.00
    10.5.hasDecimal // returns true

    10.formatToCurrency() // returns R$ 10,00
    money.formatToCurrency(symbol: '€') // returns €1.23
    1345.toRealWithFormatting() // returns R$ 13,45

    0.55.toPercentage() // returns "55,0%"
    3.5.toPercentage(separator: PercentageSeparator.dot) // returns "3.5%"

    10.lessThan(20) // returns false
    10.lessThan(10, needToBeEqual: true) // returns true
    10.greaterThan(10) // returns false
    10.isBetween(5, 20) // returns true
    25.isBetween(50, 10) // returns true

    2.0.pow(3.0) // returns 8.0
    3.141592653589793.toDegrees // returns 180.0
    180.0.toRadians // returns  3.141592653589793;
    10.5.roundToNearest(5) // returns 10

    3.padLeft(4, '0') // returns '0023'
    3.padRight(4, '0') // returns '2300'
    ```

## 0.0.2 (2023-03-09)

- Created the file `string_extensions.dart`, with methods to clean, format and convert
strings, for example:

    ```dart
    'Abc123'.digitsOnly() // returns '123'
    'abc123xyz456'.withoutDigits() // returns 'abcxyz'
    '123.456.789-90'.cleanCpf // returns '12345678990'
    '45810-000'.cleanZipCode // returns '45810000'
    '+55 (73) 99999-9999'.cleanPhone // returns '55739999999999'
    '10.67'.isNumeric // returns true
    'Flutter is awesome'.capitalize // returns 'Fluter is awesome'
    'John wick'.firstName // returns 'John'
    '09/03/2023'.toDateTime // returns DateTime(2023, 03, 09)
    ```

- Created the `context_extensions.dart` file, with methods to facilitate access to `ThemeData` and other information, for example:

    ```dart
    context.screenSize
    context.screenHeight
    context.screenWidth
    context.isMobile()
    context.isTablet()
    context.isDesktop()
    ```

## 0.0.1 (2023-03-06)

- Initial project setup.
