import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:build_context_provider/build_context_provider.dart';

void main() {
  group(
    'GIVEN ListenerThatRunsFunctionsWithBuildContext',
    () {
      group(
        'WHEN is used ',
        () {
          testWidgets(
            'THEN should display no visible widgets',
            (tester) async {
              await _pumpWidget(tester);

              expect(
                find.byWidgetPredicate((widget) => widget is Visibility && widget.visible == false),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'THEN should insert AnimatedBuilder into the widget',
            (tester) async {
              await _pumpWidget(tester);

              expect(
                find.descendant(
                  of: find.byType(ListenerThatRunsFunctionsWithBuildContext),
                  matching: find.byType(AnimatedBuilder),
                ),
                findsOneWidget,
              );
            },
          );
        },
      );
    },
  );
}

Future<void> _pumpWidget(WidgetTester tester) {
  return tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: ListenerThatRunsFunctionsWithBuildContext(),
      ),
    ),
  );
}
