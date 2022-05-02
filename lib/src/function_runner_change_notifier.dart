import 'dart:async';

import 'package:flutter/widgets.dart';

final funcstionsStreamController = StreamController<void Function(BuildContext)?>();

class FunctionRunnerChangeNotifier {
  void runFunction(Function(BuildContext) function) {
    funcstionsStreamController.add(function);
  }

  void dispose() {
    funcstionsStreamController.close();
  }
}

final functionRunnerChangeNotifier = FunctionRunnerChangeNotifier();
