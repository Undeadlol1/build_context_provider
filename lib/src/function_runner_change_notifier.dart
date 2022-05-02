import 'dart:async';

import 'package:flutter/widgets.dart';

final functionsStreamController = StreamController<void Function(BuildContext)?>();

class FunctionRunnerChangeNotifier {
  void runFunction(Function(BuildContext) function) {
    functionsStreamController.add(function);
  }

  Future dispose() {
    return functionsStreamController.close();
  }
}
