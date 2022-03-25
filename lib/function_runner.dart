import 'package:flutter/widgets.dart';
import 'function_runner_change_notifier.dart';

class FunctionRunner {
  static void runFunction(
    void Function(BuildContext) functionToRun,
  ) {
    functionRunnerChangeNotifier.runFunction(functionToRun);
  }
}
