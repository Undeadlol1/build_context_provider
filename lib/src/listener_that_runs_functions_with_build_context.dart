import 'dart:async';

import 'package:flutter/widgets.dart';

import 'function_runner_change_notifier.dart';

/// A widget that runs the functions with build context.
/// Without this widget present in the application functions will not run.
class ListenerThatRunsFunctionsWithBuildContext extends StatelessWidget {
  const ListenerThatRunsFunctionsWithBuildContext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FunctionRunnerChangeNotifier.stream,
      builder: (context, AsyncSnapshot<void Function(BuildContext)?> snapshot) {
        if (snapshot.hasData) {
          _runFunctionWhenNotified(functionToRun: snapshot.data, buildContext: context);
        }

        return Visibility(
          visible: false,
          child: Container(),
        );
      },
    );
  }

  void _runFunctionWhenNotified({
    required BuildContext buildContext,
    void Function(BuildContext)? functionToRun,
  }) {
    Future.microtask(
      () {
        functionToRun == null ? null : functionToRun(buildContext);
      },
    );
  }
}
