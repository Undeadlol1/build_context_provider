library run_function_with_context_anywhere;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './function_runner_cubit.dart';

class InvisibleListenerThatRunsFunctionsWithBuildContext
    extends StatelessWidget {
  final FunctionRunnerCubit? optionalFunctionRunnerCubitForTesting;
  const InvisibleListenerThatRunsFunctionsWithBuildContext(
      {Key? key, this.optionalFunctionRunnerCubitForTesting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FunctionRunnerCubit>(
      create: (_) =>
          optionalFunctionRunnerCubitForTesting ?? FunctionRunnerCubit(),
      child: BlocListener<FunctionRunnerCubit, ContextListenerState>(
        listener: (context, state) {
          if (state is FunctionRunnerWithFunctionToRun) {
            state.function();
          }
        },
        child: Container(),
      ),
    );
  }
}
