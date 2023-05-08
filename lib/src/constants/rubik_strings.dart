import '../types/rubik_types.dart';

typedef RubikDurationSuffixes = List<RubikStringNames>;
typedef RubikWeekDayStrings = Map<int, RubikStringNames>;
typedef RubikMonthStrings = Map<int, RubikStringNames>;

/// This class to provide all the strings used in the library.
/// {@tool snippet}
/// ```dart
/// final weekdays = RubikStrings.weekdaysByLocale();
/// weekdays[1].fullName // returns 'Segunda'
///
/// final months = RubikStrings.monthsByLocale();
/// months[1].fullName // returns 'Janeiro'
/// ```
/// {@end-tool}
abstract class RubikStrings {
  /// The default locale used in the library, `pt_BR`.
  static const String defaultLocale = 'pt_BR';

  /// The default currency symbol used in the library, `R$`.
  static const String defaultCurrencySymbol = r'R$ ';

  /// Returns a map with the weekdays names.
  /// The keys are the weekdays numbers.
  /// The values are the weekdays names.
  /// The default locale is `pt_BR`.
  /// {@tool snippet}
  /// ```dart
  /// final weekdays = RubikStrings.weekdaysByLocale();
  /// weekdays[1].fullName // returns 'Segunda'
  /// weekdays[DateTime.tuesday].shortName // returns 'Ter'
  /// weekdays[DateTime.wednesday].abbreviations // returns ['Quarta-feira']
  /// ```
  /// {@end-tool}
  static RubikWeekDayStrings weekdaysByLocale({String locale = defaultLocale}) {
    final weekdays = {
      'pt_BR': {
        DateTime.monday: const RubikStringNames(
          'Segunda-feira',
          shortName: 'Seg',
          abbreviations: ['Segunda'],
        ),
        DateTime.tuesday: const RubikStringNames(
          'Terça-feira',
          shortName: 'Ter',
          abbreviations: ['Terça'],
        ),
        DateTime.wednesday: const RubikStringNames(
          'Quarta-feira',
          shortName: 'Qua',
          abbreviations: ['Quarta'],
        ),
        DateTime.thursday: const RubikStringNames(
          'Quinta-feira',
          shortName: 'Qui',
          abbreviations: ['Quinta'],
        ),
        DateTime.friday: const RubikStringNames(
          'Sexta-feira',
          shortName: 'Sex',
          abbreviations: ['Sexta'],
        ),
        DateTime.saturday: const RubikStringNames(
          'Sábado',
          shortName: 'Sáb',
        ),
        DateTime.sunday: const RubikStringNames(
          'Domingo',
          shortName: 'Dom',
        ),
      },
      'en': {
        DateTime.monday: const RubikStringNames(
          'Monday',
          shortName: 'Mon',
        ),
        DateTime.tuesday: const RubikStringNames(
          'Tuesday',
          shortName: 'Tue',
        ),
        DateTime.wednesday: const RubikStringNames(
          'Wednesday',
          shortName: 'Wed',
        ),
        DateTime.thursday: const RubikStringNames(
          'Thursday',
          shortName: 'Thu',
        ),
        DateTime.friday: const RubikStringNames(
          'Friday',
          shortName: 'Fri',
        ),
        DateTime.saturday: const RubikStringNames(
          'Saturday',
          shortName: 'Sat',
        ),
        DateTime.sunday: const RubikStringNames(
          'Sunday',
          shortName: 'Sun',
        ),
      },
    };

    return weekdays[locale] ?? {};
  }

  /// Returns a map with the months names.
  /// The keys are the months numbers.
  /// The values are the months names.
  /// The default locale is `pt_BR`.
  /// {@tool snippet}
  /// ```dart
  /// final months = RubikStrings.monthsByLocale();
  /// months[1].fullName // returns 'Janeiro'
  /// months[DateTime.january].shortName // returns 'Jan'
  /// months[DateTime.february].abbreviations // returns ['Fevereiro']
  /// ```
  /// {@end-tool}
  static RubikMonthStrings monthsByLocale({String locale = defaultLocale}) {
    final months = {
      'pt_BR': {
        DateTime.january: const RubikStringNames(
          'Janeiro',
          shortName: 'Jan',
        ),
        DateTime.february: const RubikStringNames(
          'Fevereiro',
          shortName: 'Fev',
        ),
        DateTime.march: const RubikStringNames(
          'Março',
          shortName: 'Mar',
        ),
        DateTime.april: const RubikStringNames(
          'Abril',
          shortName: 'Abr',
        ),
        DateTime.may: const RubikStringNames(
          'Maio',
          shortName: 'Mai',
        ),
        DateTime.june: const RubikStringNames(
          'Junho',
          shortName: 'Jun',
        ),
        DateTime.july: const RubikStringNames(
          'Julho',
          shortName: 'Jul',
        ),
        DateTime.august: const RubikStringNames(
          'Agosto',
          shortName: 'Ago',
        ),
        DateTime.september: const RubikStringNames(
          'Setembro',
          shortName: 'Set',
        ),
        DateTime.october: const RubikStringNames(
          'Outubro',
          shortName: 'Out',
        ),
        DateTime.november: const RubikStringNames(
          'Novembro',
          shortName: 'Nov',
        ),
        DateTime.december: const RubikStringNames(
          'Dezembro',
          shortName: 'Dez',
        ),
      },
      'en': {
        DateTime.january: const RubikStringNames(
          'January',
          shortName: 'Jan',
        ),
        DateTime.february: const RubikStringNames(
          'February',
          shortName: 'Feb',
        ),
        DateTime.march: const RubikStringNames(
          'March',
          shortName: 'Mar',
        ),
        DateTime.april: const RubikStringNames(
          'April',
          shortName: 'Apr',
        ),
        DateTime.may: const RubikStringNames(
          'May',
          shortName: 'May',
        ),
        DateTime.june: const RubikStringNames(
          'June',
          shortName: 'Jun',
        ),
        DateTime.july: const RubikStringNames(
          'July',
          shortName: 'Jul',
        ),
        DateTime.august: const RubikStringNames(
          'August',
          shortName: 'Aug',
        ),
        DateTime.september: const RubikStringNames(
          'September',
          shortName: 'Sep',
        ),
        DateTime.october: const RubikStringNames(
          'October',
          shortName: 'Oct',
        ),
        DateTime.november: const RubikStringNames(
          'November',
          shortName: 'Nov',
        ),
        DateTime.december: const RubikStringNames(
          'December',
          shortName: 'Dec',
        ),
      },
    };

    return months[locale] ?? {};
  }

  /// Returns a map with the durations names.
  /// The keys are the durations numbers.
  /// The values are the durations names.
  /// The default locale is `pt_BR`.
  /// {@tool snippet}
  /// ```dart
  /// final durations = RubikStrings.durationsByLocale();
  /// durations[1].fullName // returns 'dias'
  /// durations[1].shortName // returns 'd'
  /// ```
  /// {@end-tool}
  static List<RubikStringNames> timeSuffixes({String locale = defaultLocale}) {
    final suffiexs = {
      'pt_BR': [
        const RubikStringNames(
          'dias',
          shortName: 'd',
          abbreviations: ['dia'],
        ),
        const RubikStringNames(
          'horas',
          shortName: 'h',
          abbreviations: ['hora'],
        ),
        const RubikStringNames(
          'minutos',
          shortName: 'm',
          abbreviations: ['minuto'],
        ),
        const RubikStringNames(
          'segundos',
          shortName: 's',
          abbreviations: ['segundo'],
        ),
      ],
      'en': [
        const RubikStringNames(
          'days',
          shortName: 'd',
          abbreviations: ['day'],
        ),
        const RubikStringNames(
          'hours',
          shortName: 'h',
          abbreviations: ['hour'],
        ),
        const RubikStringNames(
          'minutes',
          shortName: 'm',
          abbreviations: ['minute'],
        ),
        const RubikStringNames(
          'seconds',
          shortName: 's',
          abbreviations: ['second'],
        ),
      ],
    };

    return suffiexs[locale] ?? <RubikStringNames>[];
  }

  /// Returns a list of string contains the black list of CPF.
  static Strings cpfBlockList() => [
        '00000000000',
        '11111111111',
        '22222222222',
        '33333333333',
        '44444444444',
        '55555555555',
        '66666666666',
        '77777777777',
        '88888888888',
        '99999999999',
        '12345678909',
      ];

  /// Returns a list of string contains the black list of CNPJ.
  static Strings cnpjBlockList() => [
        '00000000000000',
        '11111111111111',
        '22222222222222',
        '33333333333333',
        '44444444444444',
        '55555555555555',
        '66666666666666',
        '77777777777777',
        '88888888888888',
        '99999999999999',
      ];
}
