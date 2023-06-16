import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/components/horizontal_spacing.dart';

void main() {
  group('Components.HorizontalSpacing', () {
    testWidgets(
      'should create HorizontalSpacing with widgth eguals 20.0',
      (tester) async {
        const horizontalSpacing = HorizontalSpacing(20.0);

        expect(horizontalSpacing.width, equals(20.0));

        await tester.pumpWidget(horizontalSpacing);
        expect(find.byType(SizedBox), findsOneWidget);
      },
    );

    testWidgets(
      'should occupation 0.0 height and 150.0 width space into Row',
      (tester) async {
        const Key rowKey = Key('row');
        const Key child0Key = Key('child0Key');

        await tester.pumpWidget(Center(
          child: Row(
            key: rowKey,
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(height: 20.0, width: 100.0),
              HorizontalSpacing(key: child0Key, 150.0),
              SizedBox(height: 20.0, width: 100.0),
            ],
          ),
        ));

        RenderBox renderBox = tester.renderObject(find.byKey(rowKey));
        expect(renderBox.size.width, equals(350.0));
        expect(renderBox.size.height, equals(20.0));

        renderBox = tester.renderObject(find.byKey(child0Key));
        expect(renderBox.size.width, equals(150));
        expect(renderBox.size.height, equals(0.0));
      },
    );
  });
}
