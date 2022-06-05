import 'package:flutter/widgets.dart';
import 'function_runner_change_notifier.dart';

class BuildContextProvider {
  void call(
    void Function(BuildContext) functionToRun,
  ) {
    functionRunnerChangeNotifier.runFunction(functionToRun);
  }
}
