import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:build_context_provider/build_context_provider.dart';

class _DummyClassToMock {
  void firstFunctionToTest(BuildContext context) {}
  void secondFunctionToTest(BuildContext context) {}
  bool functionThatReturnsValue(BuildContext context) => true;
}

class _MockedDummyClass extends Mock implements _DummyClassToMock {}

class _MockedBuildContext extends Mock implements BuildContext {}

final _mockedClassWithFunctions = _MockedDummyClass();

void main() {
  group(
    'Run function with build context tests - ',
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

      testWidgets(
        'WHEN a function is added '
        'THEN returned result from function should be usable',
        (tester) async {
          bool aValueToBeChangedToTrue = false;
          int howManyTimesHaveTheFunctionRan = 0;

          bool functionThatReturnsValue(BuildContext context) {
            ++howManyTimesHaveTheFunctionRan;
            return true;
          }

          void aFunctionThatCapturesReturnedResult(BuildContext context) {
            aValueToBeChangedToTrue = functionThatReturnsValue(context);
          }

          await _pumpWidget(tester);
          BuildContextProvider.provideBuildContext(aFunctionThatCapturesReturnedResult);
          await tester.pump();

          expect(aValueToBeChangedToTrue, isTrue);
          expect(howManyTimesHaveTheFunctionRan, 1);
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
