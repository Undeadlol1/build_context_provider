import 'package:flutter/widgets.dart';

import 'function_runner_change_notifier.dart';

/// A widget that runs the functions with build context.
/// Without this widget present in the application functions will not run.
class ListenerThatRunsFunctionsWithBuildContext extends StatefulWidget {
  const ListenerThatRunsFunctionsWithBuildContext({Key? key}) : super(key: key);

  @override
  State<ListenerThatRunsFunctionsWithBuildContext> createState() =>
      _ListenerThatRunsFunctionsWithBuildContextState();
}

class _ListenerThatRunsFunctionsWithBuildContextState
    extends State<ListenerThatRunsFunctionsWithBuildContext> {
  bool _wasListenerAddedToChangeNotifier = false;

  @override
  void dispose() {
    functionRunnerChangeNotifier.removeListener(_runFunctionsWhenAddedListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setupUpFunctionRunnerListener();

    return AnimatedBuilder(
      animation: functionRunnerChangeNotifier,
      child: Visibility(
        visible: false,
        child: Container(),
      ),
      builder: (_, child) => child!,
    );
  }

  void _setupUpFunctionRunnerListener() {
    if (_wasListenerAddedToChangeNotifier || functionRunnerChangeNotifier.hasListeners) {
      return;
    }

    functionRunnerChangeNotifier.addListener(_runFunctionsWhenAddedListener);
    setState(() => _wasListenerAddedToChangeNotifier = true);
  }

  void _runFunctionsWhenAddedListener() {
    Future.microtask(() {
      if (functionRunnerChangeNotifier.functionToRun == null) {
        return;
      }

      functionRunnerChangeNotifier.functionToRun!(context);
    });
  }
}
