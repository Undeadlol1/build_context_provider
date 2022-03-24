import 'package:flutter/widgets.dart';

import 'function_runner_cubit.dart';

class FunctionRunner {
  static void runFunction(
    void Function(BuildContext) functionToRun,
  ) {
    functionRunnerCubit.runFunction(functionToRun);
  }
}
