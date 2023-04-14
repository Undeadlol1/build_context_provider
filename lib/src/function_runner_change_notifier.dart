import 'dart:developer';

import 'package:flutter/widgets.dart';

class _FunctionRunnerChangeNotifier extends ChangeNotifier {
  void Function(BuildContext)? functionToRun;

  void runFunction(Function(BuildContext) function) {
    try {
      functionToRun = function;
      notifyListeners();
    } catch (e) {
      log('Error in BuildContextProvider: $e');
    }
  }
}

final functionRunnerChangeNotifier = _FunctionRunnerChangeNotifier();
