import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'function_runner_change_notifier.dart';

class BuildContextProvider {
  void call(
    void Function(BuildContext) functionToRun,
  ) {
    try {
      functionRunnerChangeNotifier.runFunction(functionToRun);
    } catch (e) {
      log('Error in BuildContextProvider: $e');
    }
  }
}
