library run_function_with_context_anywhere;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContextfullFunctionRunner extends StatelessWidget {
  const ContextfullFunctionRunner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<_FunctionRunnerCubit, _ContextListenerState>(
      listener: (context, state) {
        if (state is _FunctionRunnerWithFunctionToRun) {
          state.function();
        }
      },
      child: Container(),
    );
  }
}

abstract class _ContextListenerState {}

class _FunctionRunnerWithFunctionToRun extends _ContextListenerState {
  final VoidCallback function;

  _FunctionRunnerWithFunctionToRun({required this.function});
}

class _FunctionRunnerWithoutFunctionToRun extends _ContextListenerState {}

class _FunctionRunnerCubit extends Cubit<_ContextListenerState> {
  _FunctionRunnerCubit() : super(_FunctionRunnerWithoutFunctionToRun());

  void runFunction(VoidCallback functionToRun) {
    emit(
      _FunctionRunnerWithFunctionToRun(function: functionToRun),
    );
    Future.microtask(() => emit(_FunctionRunnerWithoutFunctionToRun()));
  }
}
