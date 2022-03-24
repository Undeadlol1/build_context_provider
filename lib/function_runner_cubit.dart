import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

abstract class ContextListenerState {}

class FunctionRunnerWithFunctionToRun extends ContextListenerState {
  final VoidCallback function;

  FunctionRunnerWithFunctionToRun({required this.function});
}

class FunctionRunnerWithoutFunctionToRun extends ContextListenerState {}

class FunctionRunnerCubit extends Cubit<ContextListenerState> {
  FunctionRunnerCubit() : super(FunctionRunnerWithoutFunctionToRun());

  void runFunction(VoidCallback functionToRun) {
    emit(
      FunctionRunnerWithFunctionToRun(function: functionToRun),
    );
    Future.microtask(() => emit(FunctionRunnerWithoutFunctionToRun()));
  }
}
