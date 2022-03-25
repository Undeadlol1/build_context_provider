library run_function_with_context_anywhere;

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:run_function_with_context_anywhere/function_runner_change_notifier.dart';

class InvisibleListenerThatRunsFunctionsWithBuildContext extends StatefulWidget {
  const InvisibleListenerThatRunsFunctionsWithBuildContext({Key? key}) : super(key: key);

  @override
  State<InvisibleListenerThatRunsFunctionsWithBuildContext> createState() =>
      _InvisibleListenerThatRunsFunctionsWithBuildContextState();
}

class _InvisibleListenerThatRunsFunctionsWithBuildContextState
    extends State<InvisibleListenerThatRunsFunctionsWithBuildContext> {
  bool _wasListenerAddedToChangeNotifier = false;

  @override
  void dispose() {
    functionRunnerChangeNotifier.removeListener(_runFunctionsWhenAdded);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_wasListenerAddedToChangeNotifier == false) {
      functionRunnerChangeNotifier.addListener(_runFunctionsWhenAdded);
      setState(() => _wasListenerAddedToChangeNotifier = true);
    }

    return AnimatedBuilder(
      animation: functionRunnerChangeNotifier,
      child: Visibility(
        visible: false,
        child: Container(),
      ),
      builder: (_, child) => child!,
    );
  }

  void _runFunctionsWhenAdded() {
    Future.microtask(() {
      if (functionRunnerChangeNotifier.functionToRun == null) {
        return;
      }

      functionRunnerChangeNotifier.functionToRun!(context);
    });
  }
}
