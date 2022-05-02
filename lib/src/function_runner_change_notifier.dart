import 'dart:async';

import 'package:flutter/widgets.dart';

final functionRunnerStream = StreamController<void Function(BuildContext)?>();

class FunctionRunnerChangeNotifier {
  void runFunction(Function(BuildContext) function) {
    functionRunnerStream.add(function);
  }

  void dispose() {
    functionRunnerStream.close();
  }
}

final functionRunnerChangeNotifier = FunctionRunnerChangeNotifier();
