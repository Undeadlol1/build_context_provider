import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:run_function_with_context_anywhere/invisible_listener_that_runs_functions_with_build_context.dart';

class _DummyClassToMock {
  void functionToTest(BuildContext context) {}
}

class _MockedDummyClass extends Mock implements _DummyClassToMock {}

class _MockedBuildContext extends Mock implements BuildContext {}

final _mockedDummyClass = _MockedDummyClass();
final _mockedBuildContext = _MockedBuildContext();

void main() {
  setUp(() {
    // registerFallbackValue(_mockedBuildContext);
    // when(_mockedFunctionCall).thenReturn(null);
  });

  group(
    'GIVEN InvisibleListenerThatRunsFunctionsWithBuildContext',
    () {
      // testWidgets(
      //   'WHEN a function is pushed to the function runner cubit '
      //   'THEN should run the function with build context',
      //   (tester) async {
      //     await _pumpWidget(tester).then((_) => _functionRunnerCubit
      //         .runFunction(_mockedDummyClass.functionToTest));
      //     await tester.pump();

      //     verify(_mockedFunctionCall).called(1);
      //   },
      // );

      group(
        'WHEN is used ',
        () {
          testWidgets(
            'THEN should display no visible widgets',
            (tester) async {
              await _pumpWidget(tester);

              expect(
                find.byWidgetPredicate((widget) =>
                    widget is Visibility && widget.visible == false),
                findsOneWidget,
              );
            },
          );

          // testWidgets(
          //   'THEN should insert cubit into the widget',
          //   (tester) async {
          //     await _pumpWidget(tester);

          //     expect(
          //       find.byWidgetPredicate((widget) => widget is BlocProvider),
          //       findsOneWidget,
          //     );
          //   },
          // );
        },
      );
    },
  );
}

Future<void> _pumpWidget(WidgetTester tester) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: InvisibleListenerThatRunsFunctionsWithBuildContext(
            // optionalFunctionRunnerCubitForTesting: _functionRunnerCubit,
            ),
      ),
    ),
  );
}

void _mockedFunctionCall() {
  _mockedDummyClass.functionToTest(any());
}
