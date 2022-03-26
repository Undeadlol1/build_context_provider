import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:run_function_with_context_anywhere/invisible_listener_that_runs_functions_with_build_context.dart';
import 'package:run_function_with_context_anywhere/run_function_with_context_anywhere.dart';

class _DummyClassToMock {
  void firstFunctionToTest(BuildContext context) {}
  void secondFunctionToTest(BuildContext context) {}
}

class _MockedDummyClass extends Mock implements _DummyClassToMock {}

class _MockedBuildContext extends Mock implements BuildContext {}

final _mockedClassWithFunctions = _MockedDummyClass();

void main() {
  group(
    'Run function with context anywhere tests - ',
    () {
      setUp(() {
        registerFallbackValue(_MockedBuildContext());

        when(_mockedFunctionCall).thenReturn(null);
      });

      tearDown(() {
        reset(_mockedClassWithFunctions);
        clearInteractions(_mockedClassWithFunctions);
      });

      testWidgets(
        'WHEN a function is added '
        'THEN should run the function with build context',
        (tester) async {
          await _pumpWidget(tester);
          BuildContextProvider.provideBuildContext(_mockedClassWithFunctions.firstFunctionToTest);
          await tester.pump();

          verify(_mockedFunctionCall).called(1);
        },
      );

      testWidgets(
        'WHEN a function is added twice '
        'THEN should run the functions with build context',
        (tester) async {
          void mockedFunctionCall() {
            _mockedClassWithFunctions.secondFunctionToTest(any());
          }

          await _pumpWidget(tester);
          BuildContextProvider.provideBuildContext(_mockedClassWithFunctions.secondFunctionToTest);
          BuildContextProvider.provideBuildContext(_mockedClassWithFunctions.secondFunctionToTest);
          await tester.pump();

          verify(mockedFunctionCall).called(2);
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
              const ListenerThatRunsFunctionsWithBuildContext(),
            ],
          ),
        ),
      ),
    ),
  );
}

void _mockedFunctionCall() {
  _mockedClassWithFunctions.firstFunctionToTest(any());
}
