import 'dart:async';

import 'package:flutter/widgets.dart';

final functionRunnerStream = StreamController<void Function(BuildContext)?>();

class FunctionRunnerChangeNotifier {
  static final stream = functionRunnerStream.stream.asBroadcastStream();

  void runFunction(Function(BuildContext) function) {
    functionRunnerStream.add(function);
  }

  void dispose() {
    functionRunnerStream.close();
  }
}

final functionRunnerChangeNotifier = FunctionRunnerChangeNotifier();
