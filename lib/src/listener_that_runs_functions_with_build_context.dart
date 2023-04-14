import 'dart:developer';

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
    functionRunnerChangeNotifier.removeListener(_runFunctionWhenNotified);
    super.dispose();
  }

  void _runFunctionWhenNotified() async {
    try {
      log('Running function with build context...');
      final functionToRun = functionRunnerChangeNotifier.functionToRun;

      await Future.microtask(
        () => functionToRun == null ? null : functionToRun(context),
      );
    } catch (e) {
      log('Error in BuildContextProvider: $e');
    }
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
    log('Setting up function runner listener...');
    if (_wasListenerAddedToChangeNotifier ||
        // ignore: invalid_use_of_protected_member
        functionRunnerChangeNotifier.hasListeners) {
      log('Function runner listener was already set up.');
      return;
    }

    functionRunnerChangeNotifier.addListener(_runFunctionWhenNotified);
    log('Function runner listener was set up.');
    log('Rebuilding...');
    setState(() => _wasListenerAddedToChangeNotifier = true);
  }
}
