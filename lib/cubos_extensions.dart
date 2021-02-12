library cubos_extensions;

extension CubosStringExtensions on String {
  /// Returns only numbers of a CPF string, removing all special characters('.' and '-')
  String get cleanCpf => this.replaceAll('.', '').replaceAll('-', '').trim();

  /// Returns only numbers of a CEP string, removing all special characters.
  String get cleanCep => this.replaceAll('-', '')..trim();

  /// Returns only numbers of a phone string, removing all special characters.
  String get cleanPhone => this
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('-', '')
      .replaceAll(' ', '')
      .replaceAll('+', '')
      .trim();

  /// Returns [true] is the string is a number.
  bool get isNumeric {
    if (this == null) {
      return false;
    }
    return double.tryParse(this) != null;
  }

  /// Returns [true] if the String is null or blank.
  bool get isNullOrBlank => this?.trim()?.isEmpty ?? true;

  /// Returns [true] if the String is NOT null or blank.
  bool get isNotNullOrBlank => !this.isNullOrBlank;

  /// Capitalize the first letter.
  String get capitalize {
    if (this.isNullOrBlank) return this;

    return this.length > 1
        ? '${this[0].toUpperCase()}${this.substring(1)}'
        : this.toUpperCase();
  }

  /// Returns given names with all the word capitalized, except some words such as: de, da, das, do,
  /// dos, e. Brazil short name (BR) and states (SP, BA, MG...) are return in all upper case.
  ///
  /// Returns a empty string if the value is null or blank.
  String get capitalizeWords {
    if (this.isNullOrBlank) {
      return '';
    }
    final str = this.toLowerCase().split(' ').map((word) {
      if (word.isBrazilianCountryOrState) return word.toUpperCase();
      return word.isCapitalizable ? word.capitalize : word;
    }).join(' ');
    //ensures that first letter is capitalized event if is not capitalizable
    return str.capitalize;
  }

  String get firstName {
    if (this.isNullOrBlank) return '';
    return this.split(' ')[0].capitalize;
  }

  /// Returns true for words that first capital letter is applicable in pt-br
  bool get isCapitalizable {
    final notCapitalizableWords = ['de', 'da', 'das', 'do', 'dos', 'e'];

    return !notCapitalizableWords.contains(this.toLowerCase());
  }

  /// Returns if a given string is a short string of brazil or brazilian states
  /// Ex: Returns true for: Br, br, BR, SP, ba, To.
  bool get isBrazilianCountryOrState {
    final brazilAndStates = [
      'AC',
      'AL',
      'AM',
      'AP',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MG',
      'MG',
      'MS',
      'MT',
      'PA',
      'PB',
      'PE',
      'PI',
      'PR',
      'RJ',
      'RN',
      'RO',
      'RR',
      'RS',
      'SC',
      'SE',
      'SP',
      'TO',
      'BR'
    ];

    return brazilAndStates.contains(this.toUpperCase());
  }

  bool get hasUppercase => this.contains(new RegExp(r'[A-Z]'));

  bool get hasLowercase => this.contains(new RegExp(r'[a-z]'));

  bool get hasLetter => this.contains(new RegExp(r'[a-z, A-Z]'));

  bool get hasDigits => this.contains(new RegExp(r'[0-9]'));

  bool get hasSpecialCharacters =>
      this.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>-_+=]'));

  /// Converts dd/mm/yyyy String to Datetime.
  /// Returns null if the String is in the wrong format;
  DateTime get toDateTime {
    return DateTime.tryParse(this);
  }

  int get toInt {
    return int.tryParse(this);
  }
}

/// Returns date String in dd/mm/yyyy format.
extension CubosDateTimeExtensions on DateTime {
  String get toDateTimeStr {
    final dateTime = this;
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }

  String get toIsoStr {
    final dateTime = this;
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  DateTime subtractYears(int years) {
    return DateTime(this.year - years, this.month, this.day);
  }

  /// Returns the weekday in pt-br
  ///
  /// EX: Segunda-feira, Terça-feira...
  String get toWeekdayStr {
    final weekday = this.weekday;
    switch (weekday) {
      case DateTime.monday:
        return 'Segunda-feira';
        break;
      case DateTime.tuesday:
        return 'Terça-feira';
        break;
      case DateTime.wednesday:
        return 'Quarta-feira';
        break;
      case DateTime.thursday:
        return 'Quinta-feira';
        break;
      case DateTime.friday:
        return 'Sexta-feira';
        break;
      case DateTime.saturday:
        return 'Sábado';
        break;
      case DateTime.sunday:
        return 'Domingo';
        break;
      default:
        return '';
    }
  }

  /// Returns the time in HH:MM 24h format.
  String get toTimeStr {
    final hours = this.hour.toString().padLeft(2, '');
    final minutes = this.minute.toString().padLeft(2, '0');

    return '$hours:$minutes';
  }

  /// Returns the month in pt-br
  ///
  /// Ex: Janeiro, Fevereiro...
  String get toMonthStr {
    final month = this.month;

    switch (month) {
      case DateTime.january:
        return 'Janeiro';
        break;
      case DateTime.february:
        return 'Fevereiro';
        break;
      case DateTime.march:
        return 'Março';
        break;
      case DateTime.april:
        return 'Abril';
        break;
      case DateTime.may:
        return 'Maio';
        break;
      case DateTime.june:
        return 'Junho';
        break;
      case DateTime.july:
        return 'Julho';
        break;
      case DateTime.august:
        return 'Agosto';
        break;
      case DateTime.september:
        return 'Setembro';
        break;
      case DateTime.october:
        return 'Outubro';
        break;
      case DateTime.november:
        return 'Novembro';
        break;
      case DateTime.december:
        return 'Dezembro';
        break;
      default:
        return '';
    }
  }

  /// Returns the complete date and time in pt-br.
  ///
  /// Ex: 12 de abril de 2020
  String get toCompleteDateStr {
    final month = this.toMonthStr;
    return '$day de $month de $year';
  }

  /// Returns the date and time in "DD/MM/AAAA - HH:MM" format
  String get toDateAndTimeStr {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();
    final hours = this.hour.toString().padLeft(2, '0');
    final minutes = this.minute.toString().padLeft(2, '0');

    return '$day/$month/$year - $hours:$minutes';
  }
}

extension CubosListExtensions on List<dynamic> {
  /// Returns the last index integer. If the list is empty, returns -1.
  int get lastIndex => this.length - 1;

  /// Returns new array which is a copy of the original array, resized to the given [newSize].
  /// he copy is either truncated or padded at the end with zero values if necessary.
  ///
  /// - If [newSize] is less than the size of the original array, the copy array is truncated to the [newSize].
  /// - If [newSize] is greater than the size of the original array, the extra elements in the copy array are filled with zero values.
  List<dynamic> copyOf(int newSize) {
    var copiedList = this;
    final copiedListLastIndex = copiedList.length - 1;
    var newList = List(newSize);

    newList.asMap().forEach((index, it) {
      newList[index] = (index <= copiedListLastIndex) ? copiedList[index] : 0;
    });

    return newList;
  }

  /// Removes last object from this list that satisfy [test].
  ///
  /// An object [:o:] satisfies [test] if [:test(o):] is true.
  ///
  ///     List<String> numbers = ['one', 'two', 'three', 'four'];
  ///     numbers.removeLastWhere((item) => item.length == 3);
  ///     numbers.join(', '); // 'one, three, four'
  ///
  /// Throws an [UnsupportedError] if this is a fixed-length list and the [test] returns true.
  void removeLastWhere(bool Function(dynamic it) test) {
    final lastIndex = this.length - 1;

    for (var i = lastIndex; i >= 0; i--) {
      print(i);
      if (test(this[i])) {
        this.removeAt(i);
        break;
      }
    }
  }

  /// Returns [true] if the list is null or empty. Returns false otherwhise.
  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }
}

extension CubosListIntExtensions on List<int> {
  ///Sum all values in a List<int>
  int get sum {
    var sum = 0;
    this.forEach((int it) {
      sum += it;
    });
    return sum;
  }
}

extension CubosDurationExtentions on Duration {
  /// Converts duration into M:SS string
  String get toTimeStr {
    final rawSeconds = this.inSeconds;
    final int minutes = (rawSeconds / 60).floor();
    final int seconds = rawSeconds % 60;

    final secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutes:$secondsStr';
  }
}
