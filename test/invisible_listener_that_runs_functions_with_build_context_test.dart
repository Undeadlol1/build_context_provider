import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:run_function_with_context_anywhere/function_runner_cubit.dart';
import 'package:run_function_with_context_anywhere/invisible_listener_that_runs_functions_with_build_context.dart';

class _DummyClassToMock {
  void functionToTest(BuildContext context) {}
}

class _MockedDummyClass extends Mock implements _DummyClassToMock {}

class _MockedBuildContext extends Mock implements BuildContext {}

final _functionRunnerCubit = FunctionRunnerCubit();
final _mockedClassWithFunctions = _MockedDummyClass();
final _mockedBuildContext = _MockedBuildContext();

void main() {
  void mockedFunctionCall() {
    _mockedClassWithFunctions.functionToTest(any());
  }

  setUp(() {
    registerFallbackValue(_mockedBuildContext);
    when(mockedFunctionCall).thenReturn(null);
  });

  group(
    'InvisibleListenerThatRunsFunctionsWithBuildContext',
    () {
      testWidgets(
        'WHEN a function is added '
        'THEN should run the function with build context',
        (tester) async {
          await _pumpWidget(tester);
          _functionRunnerCubit.runFunction(_mockedClassWithFunctions.functionToTest);
          await tester.pump();

          verify(mockedFunctionCall).called(1);
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
              InvisibleListenerThatRunsFunctionsWithBuildContext(
                optionalFunctionRunnerCubitForTesting: _functionRunnerCubit,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
