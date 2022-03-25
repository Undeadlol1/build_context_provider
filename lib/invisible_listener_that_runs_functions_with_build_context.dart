library run_function_with_context_anywhere;

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:run_function_with_context_anywhere/function_runner_change_notifier.dart';

class InvisibleListenerThatRunsFunctionsWithBuildContext
    extends StatelessWidget {
  InvisibleListenerThatRunsFunctionsWithBuildContext({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: functionRunnerChangeNotifier,
      builder: (context, child) {
        if (functionRunnerChangeNotifier.functionToRun != null) {
          functionRunnerChangeNotifier.functionToRun!(context);
        }
        return Visibility(
          visible: false,
          child: Container(),
        );
      },
    );
  }
}
