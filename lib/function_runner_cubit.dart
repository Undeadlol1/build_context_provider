import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

abstract class ContextListenerState {}

class FunctionRunnerWithFunctionToRun extends ContextListenerState {
  final void Function(BuildContext) function;

  FunctionRunnerWithFunctionToRun({required this.function});
}

class FunctionRunnerWithoutFunctionToRun extends ContextListenerState {}

class FunctionRunnerCubit extends Cubit<ContextListenerState> {
  FunctionRunnerCubit() : super(FunctionRunnerWithoutFunctionToRun());

  void runFunction(void Function(BuildContext) functionToRun) {
    debugPrint('runFunctin!');
    emit(
      FunctionRunnerWithFunctionToRun(function: functionToRun),
    );
    Future.microtask(() => emit(FunctionRunnerWithoutFunctionToRun()));
  }
}

final functionRunnerCubit = FunctionRunnerCubit();
