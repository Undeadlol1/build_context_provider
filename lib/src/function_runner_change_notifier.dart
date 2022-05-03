import 'package:flutter/widgets.dart';

import 'functions_stream_controller.dart';

class FunctionRunnerChangeNotifier {
  void runFunction(Function(BuildContext) function) {
    functionsStreamController.add(function);
  }
}
