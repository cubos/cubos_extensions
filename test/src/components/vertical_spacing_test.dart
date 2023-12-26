import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/components/vertical_spacing.dart';

void main() {
  group('Components.VerticalSpacing', () {
    testWidgets(
      'should create VerticalSpacing with height eguals 20.0',
      (tester) async {
        const verticalSpacing = VerticalSpacing(20.0);

        expect(verticalSpacing.height, equals(20.0));

        await tester.pumpWidget(verticalSpacing);
        expect(find.byType(SizedBox), findsOneWidget);
      },
    );

    testWidgets(
      'should occupation 0.0 width and 50.0 height space into Column',
      (tester) async {
        const Key columnKey = Key('column');
        const Key child0Key = Key('child0Key');

        await tester.pumpWidget(const Center(
          child: Column(
            key: columnKey,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: 100.0, height: 100.0),
              VerticalSpacing(key: child0Key, 50.0),
              SizedBox(width: 100.0, height: 150.0),
            ],
          ),
        ));

        RenderBox renderBox = tester.renderObject(find.byKey(columnKey));
        expect(renderBox.size.width, equals(100.0));
        expect(renderBox.size.height, equals(300.0));

        renderBox = tester.renderObject(find.byKey(child0Key));
        expect(renderBox.size.width, equals(0));
        expect(renderBox.size.height, equals(50.0));
      },
    );
  });
}
