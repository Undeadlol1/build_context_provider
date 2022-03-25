import 'package:flutter/widgets.dart';

// TODO rename?
class FunctionRunnerChangeNotifier extends ChangeNotifier {
  void Function(BuildContext)? functionToRun;

  // TODO rename?
  void runFunction(Function(BuildContext) function) {
    functionToRun = function;
    notifyListeners();
  }
}

final functionRunnerChangeNotifier = FunctionRunnerChangeNotifier();
