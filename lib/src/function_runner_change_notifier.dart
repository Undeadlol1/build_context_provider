import 'package:flutter/widgets.dart';

class _FunctionRunnerChangeNotifier extends ChangeNotifier {
  void Function(BuildContext)? functionToRun;

  void runFunction(Function(BuildContext) function) {
    functionToRun = function;
    notifyListeners();
  }
}

final functionRunnerChangeNotifier = _FunctionRunnerChangeNotifier();
