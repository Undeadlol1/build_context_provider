import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:run_function_with_context_anywhere/function_runner_cubit.dart';
import 'package:run_function_with_context_anywhere/invisible_listener_that_runs_functions_with_build_context.dart';

class _MockedClass extends Mock {
  void functionToTest() {}
}

final _functionRunnerCubit = FunctionRunnerCubit();
final _mockedClassWithFunctions = _MockedClass();
void main() {
  group(
    'InvisibleListenerThatRunsFunctionsWithBuildContext',
    () {
      testWidgets(
        'WHEN a function is added '
        'THEN should run the function with build context',
        (tester) async {
          void functionMock() {
            () => _mockedClassWithFunctions.functionToTest();
          }

          when(functionMock).thenReturn(null);

          await _pumpWidget(tester);
          _functionRunnerCubit.runFunction(
            _mockedClassWithFunctions.functionToTest,
          );
          await tester.pump();

          verify(functionMock).called(1);
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
