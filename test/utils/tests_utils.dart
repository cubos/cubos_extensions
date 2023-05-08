import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

typedef WidgetTestBuilder = void Function(BuildContext context);
typedef WidgetWrapperBuilder = Widget Function(Widget child);

class MaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      DefaultMaterialLocalizations.load(locale);

  @override
  bool shouldReload(MaterialLocalizationsDelegate old) => false;
}

class WidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      DefaultWidgetsLocalizations.load(locale);

  @override
  bool shouldReload(WidgetsLocalizationsDelegate old) => false;
}

abstract class TestsUtils {
  static Future<void> renderWidget(
    WidgetTester tester,
    WidgetTestBuilder builder, {
    WidgetWrapperBuilder? widgetWrapperBuilder,
  }) async {
    final child = Builder(
      builder: (BuildContext context) {
        builder(context);

        return const Placeholder();
      },
    );

    await tester.pumpWidget(MaterialApp(
      home: widgetWrapperBuilder?.call(child) ?? child,
    ));
  }

  static Future<void> renderWidgetResponsive(
    Size size,
    WidgetTester tester,
    WidgetTestBuilder builder,
  ) async {
    final child = Builder(
      builder: (BuildContext context) {
        builder(context);

        return const Placeholder();
      },
    );

    await tester.pumpWidget(MaterialApp(
      builder: (context, _) => MediaQuery(
        data: MediaQueryData(size: size),
        child: child,
      ),
      home: child,
    ));
  }

  static DateTime getDateTime([
    int year = 0,
    int month = 0,
    int day = 0,
    int hour = 0,
    int minute = 0,
    int second = 0,
  ]) {
    return DateTime(year, month, day, hour, minute, second);
  }

  static DateTime getDateTimeNow([bool withHours = false]) {
    final now = DateTime.now();

    return getDateTime(
      now.year,
      now.month,
      now.day,
      withHours ? now.hour : 0,
      withHours ? now.minute : 0,
      withHours ? now.second : 0,
    );
  }

  static Duration duration([
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
  ]) {
    return Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  static TextField generatedInput({
    Key? key,
    String hintText = 'Enter value',
    TextEditingController? controller,
    TextInputType type = TextInputType.number,
    List<TextInputFormatter> inputFormatters = const [],
  }) {
    return TextField(
      key: key,
      keyboardType: type,
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(hintText: hintText),
    );
  }

  static Future<void> renderInputsWidget(
    WidgetTester tester, {
    required Widget child,
  }) async {
    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        locale: const Locale('pt', 'BR'),
        delegates: <LocalizationsDelegate>[
          WidgetsLocalizationsDelegate(),
          MaterialLocalizationsDelegate(),
        ],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(800.0, 600.0)),
            child: Center(child: Material(child: child)),
          ),
        ),
      ),
    ));
  }
}
