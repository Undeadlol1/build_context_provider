import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:run_function_with_context_anywhere/invisible_listener_that_runs_functions_with_build_context.dart';
import 'package:run_function_with_context_anywhere/run_function_with_context_anywhere.dart';

class _DummyClassToMock {
  void functionToTest(BuildContext context) {}
}

class _MockedDummyClass extends Mock implements _DummyClassToMock {}

class _MockedBuildContext extends Mock implements BuildContext {}

final _mockedClassWithFunctions = _MockedDummyClass();

void main() {
  setUp(() {
    registerFallbackValue(_MockedBuildContext());

    when(_mockedFunctionCall).thenReturn(null);
  });

  group(
    'Run function with context anywhere tests - ',
    () {
      testWidgets(
        'WHEN a function is added '
        'THEN should run the function with build context',
        (tester) async {
          await _pumpWidget(tester);
          FunctionRunner.runFunction(_mockedClassWithFunctions.functionToTest);
          await tester.pump();

          verify(_mockedFunctionCall).called(1);
        },
      );
    },
  );
}

Future<void> _pumpWidget(WidgetTester tester) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(),
              InvisibleListenerThatRunsFunctionsWithBuildContext(),
            ],
          ),
        ),
      ),
    ),
  );
}

void _mockedFunctionCall() {
  _mockedClassWithFunctions.functionToTest(captureAny());
}
