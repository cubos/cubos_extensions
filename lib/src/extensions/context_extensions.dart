// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:rubik_utils/rubik_utils.dart';

extension RubikThemeExtensions on BuildContext {
  /// Returns the `ThemeData` of context
  ThemeData get theme => Theme.of(this);

  /// Returns the `AppBarTheme` of context
  AppBarTheme get appBarTheme => theme.appBarTheme;

  /// Returns the `ColorScheme` of context
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the `MediaQueryData` of context
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension RubikResponsiveExtensions on BuildContext {
  /// Returns the `Size` containing width and height
  Size get screenSize => mediaQuery.size;

  /// Returns screen's `height`
  double get screenHeight => mediaQuery.size.height;

  /// Returns screen's `width`
  double get screenWidth => mediaQuery.size.width;

  /// Returns `true`, if the device is mobile
  bool isMobile([double maxWidth = 360]) => screenWidth < maxWidth;

  /// Returns `true`, if the device is tablet
  bool isTablet([double minWidth = 360, double maxWidth = 840]) =>
      screenWidth >= minWidth && screenWidth < maxWidth;

  /// Returns `true`, if the device is desktop
  bool isDesktop([double maxWidth = 1024]) => screenWidth >= maxWidth;
}

extension BoxShadowExtension on BoxShadow {
  /// Creates a copy of `BoxShadow` with the given fields replaced with the
  /// new values.
  BoxShadow copyWith({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return BoxShadow(
      color: color ?? this.color,
      offset: offset ?? this.offset,
      blurRadius: blurRadius ?? this.blurRadius,
      spreadRadius: spreadRadius ?? this.spreadRadius,
    );
  }
}

extension OrientationExtension on Orientation {
  /// Returns `true`, if the device Orientation is portrait
  bool get isPortrait => this == Orientation.portrait;

  /// Returns `true`, if the device Orientation is landscape
  bool get isLandscape => this == Orientation.landscape;
}

extension FormStateExtension on GlobalKey<FormState> {
  /// Called method to dispose the `FormState`
  void dispose() => currentState?.dispose();

  /// Returns `true`, if the `FormState` is valid
  bool validate() => currentState?.validate() ?? false;
}

extension TextEditingControllerExtension on TextEditingController {
  /// Returns `false`, if the `TextEditingController` is empty
  bool get isEmpty => text.isEmpty;

  /// Returns `true`, if the `TextEditingController` is not empty
  bool get isNotEmpty => !isEmpty;

  /// Updates the `TextEditingController` with the given value
  void update(String value) => text = value;
}

extension PageControllerExtension on PageController {
  /// Returns `true`, if the `PageController` is on the last page
  bool get isOnFirstPage => pageIndex == 0;

  /// Returns `true`, if the `PageController` is on the first page
  bool isOnLastPage([int? length]) =>
      pageIndex == (length ?? page?.roundToDouble());

  /// Returns `page` of `PageController`
  int get pageIndex => page?.toInt() ?? 0;

  /// Navigates to the `next page`
  void next({Duration? duration, Curve? curve}) {
    nextPage(
      curve: curve ?? Curves.linear,
      duration: duration ?? 300.milliseconds,
    );
  }

  /// Navigates to the `previous page`
  void previous({Duration? duration, Curve? curve}) {
    previousPage(
      curve: curve ?? Curves.linear,
      duration: duration ?? 300.milliseconds,
    );
  }
}

extension SizeExtension on Size {
  /// Creates a copy of `Size` with the given fields replaced with the
  /// new values.
  Size copyWith({double? width, double? height}) => Size(
        width ?? this.width,
        height ?? this.height,
      );
}
