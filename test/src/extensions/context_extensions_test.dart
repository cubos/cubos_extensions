import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

import '../../utils/tests_utils.dart';

void main() {
  group('ContextExtensions:', () {
    group('RubikThemeExtensions:', () {
      testWidgets('should return current ThemeData of context', (tester) async {
        await TestsUtils.renderWidget(tester, (context) {
          final actual = context.theme;
          expect(actual, Theme.of(context));
        });
      });

      testWidgets('should return AppBarTheme of context', (tester) async {
        await TestsUtils.renderWidget(tester, (context) {
          final actual = context.appBarTheme;
          expect(actual, Theme.of(context).appBarTheme);
        });
      });

      testWidgets('should return ColorScheme of context', (tester) async {
        await TestsUtils.renderWidget(tester, (context) {
          final actual = context.colorScheme;
          expect(actual, Theme.of(context).colorScheme);
        });
      });

      testWidgets('should return MediaQueryData of context', (tester) async {
        await TestsUtils.renderWidget(
          tester,
          (context) {
            final actual = context.mediaQuery;
            expect(actual, MediaQuery.of(context));
          },
        );
      });
    });

    group('RubikResponsiveExtensions:', () {
      testWidgets('should return ScreenSize of context', (tester) async {
        const size = Size.square(600);

        await TestsUtils.renderWidget(
          tester,
          widgetWrapperBuilder: (child) => SizedBox(
            width: size.width,
            height: size.height,
            child: child,
          ),
          (context) {
            final actual = context.screenSize;
            expect(actual, MediaQuery.of(context).size);
            // Builder added 200 additional to width
            expect(actual.width, size.width + 200);
            expect(actual.height, size.height);
          },
        );
      });

      testWidgets('should return ScreenWidth of context', (tester) async {
        await TestsUtils.renderWidget(
          tester,
          (context) {
            final actual = context.screenWidth;
            expect(actual, MediaQuery.of(context).size.width);
          },
        );
      });

      testWidgets('should return screenHeight of context', (tester) async {
        await TestsUtils.renderWidget(
          tester,
          widgetWrapperBuilder: (child) => MaterialApp(home: child),
          (context) {
            final actual = context.screenHeight;
            expect(actual, MediaQuery.of(context).size.height);
          },
        );
      });

      testWidgets(
        'should return true if screenWidth for mobile',
        (tester) async {
          await TestsUtils.renderWidgetResponsive(
            const Size.square(340),
            tester,
            (context) => expect(context.isMobile(), true),
          );

          await TestsUtils.renderWidgetResponsive(
            const Size.square(680),
            tester,
            (context) => expect(context.isMobile(), false),
          );
        },
      );

      testWidgets(
        'should return true if screenWidth for Tablet',
        (tester) async {
          await TestsUtils.renderWidgetResponsive(
            const Size.square(820),
            tester,
            (context) => expect(context.isTablet(), true),
          );

          await TestsUtils.renderWidgetResponsive(
            const Size.square(240),
            tester,
            (context) => expect(context.isTablet(), false),
          );
        },
      );

      testWidgets(
        'should return true if screenWidth for desktop',
        (tester) async {
          await TestsUtils.renderWidgetResponsive(
            const Size.square(1024),
            tester,
            (context) => expect(context.isDesktop(), true),
          );

          await TestsUtils.renderWidgetResponsive(
            const Size.square(240),
            tester,
            (context) => expect(context.isDesktop(), false),
          );
        },
      );
    });

    group('BoxShadowExtension:', () {
      test('should return new BoxShadow with new values', () {
        const boxShadow = BoxShadow(blurRadius: 10, color: Colors.red);

        final actual = boxShadow.copyWith(
          spreadRadius: 20,
          color: Colors.blue,
          offset: const Offset(20, 20),
        );

        expect(actual.blurRadius, 10);
        expect(actual.spreadRadius, 20);
        expect(actual, isNot(boxShadow));
        expect(actual.color, Colors.blue);
        expect(actual.offset, const Offset(20, 20));
      });

      test('should not changes BoxShadow values', () {
        const boxShadow = BoxShadow(blurRadius: 10, color: Colors.red);
        final actual = boxShadow.copyWith(color: null, blurRadius: null);

        expect(actual.blurRadius, 10);
        expect(actual.color, Colors.red);
      });
    });

    group('OrientationExtension:', () {
      test('should return true if Orientation is isLandscape', () {
        const orientation = Orientation.landscape;
        expect(orientation.isLandscape, true);
        expect(orientation.isPortrait, false);
      });

      test('should return true if Orientation is isPortrait', () {
        const orientation = Orientation.portrait;
        expect(orientation.isLandscape, false);
        expect(orientation.isPortrait, true);
      });
    });

    group('TextEditingControllerExtension:', () {
      test('should return true TextEditingController.text isEmpty ', () {
        final controller = TextEditingController();

        expect(controller.isEmpty, true);
        controller.text = 'test';
        expect(controller.isEmpty, false);
        controller.dispose();
      });

      test('should return true TextEditingController.text isNotEmpty', () {
        final controller = TextEditingController();

        expect(controller.isNotEmpty, false);
        controller.text = 'test';
        expect(controller.isNotEmpty, true);
        controller.dispose();
      });

      test(
        'should change text in TextEditingController when called update method',
        () {
          final controller = TextEditingController();
          expect(controller.isEmpty, true);

          controller.update('test');
          expect(controller.isNotEmpty, true);
          expect(controller.text, 'test');
        },
      );
    });

    group('SizeExtension:', () {
      test('should return new Size with new values', () {
        const size = Size.square(200);
        final actual = size.copyWith(height: 120, width: 34);

        expect(actual.width, 34);
        expect(actual.height, 120);
        expect(actual, isNot(size));
      });

      test('should not changes BoxShadow values', () {
        const size = Size.square(200);
        final actual = size.copyWith(height: null, width: null);

        expect(actual.width, 200);
        expect(actual.height, 200);
      });
    });

    group('FormStateExtension:', () {
      testWidgets('should return bool when validate is called', (tester) async {
        final formKey = GlobalKey<FormState>();
        final controller = TextEditingController();

        await TestsUtils.renderWidget(
          tester,
          widgetWrapperBuilder: (child) => Material(
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: (value) => value == null ? 'error' : null,
              ),
            ),
          ),
          (context) {
            controller.update('test');
            expect(formKey.validate(), true);
            formKey.dispose();
          },
        );
      });
    });
  });
}
