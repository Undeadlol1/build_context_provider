import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:build_context_provider/build_context_provider.dart';

class _DummyClassToMock {
  void firstFunction(BuildContext context) {}
  void secondFunction(BuildContext context) {}
  bool functionThatReturnsValue(BuildContext context) => true;
}

class _MockedDummyClass extends Mock implements _DummyClassToMock {}

class _MockedBuildContext extends Mock implements BuildContext {}

final _mockedFunctions = _MockedDummyClass();

void main() {
  group(
    'GIVEN BuildContextProvider',
    () {
      setUp(() {
        registerFallbackValue(_MockedBuildContext());

        when(_mockedFunctionCall).thenReturn(null);
      });

      tearDown(() {
        reset(_mockedFunctions);
        clearInteractions(_mockedFunctions);
      });

      group('WHEN a function is added', () {
        testWidgets(
          'THEN should run the function with build context',
          (tester) async {
            await _pumpWidget(tester);
            provideBuildContext(_mockedFunctions.firstFunction);
            await tester.pump();

            verify(_mockedFunctionCall).called(1);
          },
        );

        testWidgets(
          'THEN returned result from function should be usable',
          (tester) async {
            int howManyTimesHaveTheFunctionRan = 0;
            bool aValueToBeReturnedFromTheFunction = false;
            bool functionThatReturnsValue(BuildContext context) {
              ++howManyTimesHaveTheFunctionRan;
              return true;
            }

            await _pumpWidget(tester);
            provideBuildContext((context) {
              aValueToBeReturnedFromTheFunction = functionThatReturnsValue(context);
            });
            await tester.pump();

            expect(aValueToBeReturnedFromTheFunction, isTrue);
            expect(howManyTimesHaveTheFunctionRan, 1);
          },
        );
      });

      testWidgets(
        'WHEN a function is added twice '
        'THEN should run the functions with build context',
        (tester) async {
          await _pumpWidget(tester);
          provideBuildContext(_mockedFunctions.secondFunction);
          provideBuildContext(_mockedFunctions.secondFunction);
          await tester.pump();

          verify(
            () => _mockedFunctions.secondFunction(any()),
          ).called(2);
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
  _mockedFunctions.firstFunction(any());
}
