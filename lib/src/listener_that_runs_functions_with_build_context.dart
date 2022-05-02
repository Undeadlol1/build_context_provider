import 'dart:async';

import 'package:flutter/widgets.dart';

import 'function_runner_change_notifier.dart';

/// A widget that runs the functions with build context.
/// Without this widget present in the application functions will not run.
class ListenerThatRunsFunctionsWithBuildContext extends StatelessWidget {
  const ListenerThatRunsFunctionsWithBuildContext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (functionsStreamController.hasListener) {
      return _invisibleWidget;
    }

    return StreamBuilder<void Function(BuildContext)?>(
      stream: functionsStreamController.stream,
      builder: (context, snapshot) {
        _runFunctionWhenNotified(
          buildContext: context,
          functionToRun: snapshot.data,
        );

        return _invisibleWidget;
      },
    );
  }

  void _runFunctionWhenNotified({
    required BuildContext buildContext,
    void Function(BuildContext)? functionToRun,
  }) {
    if (functionToRun == null) {
      return;
    }

    Future.microtask(() => functionToRun(buildContext));
  }

  static const _invisibleWidget = Visibility(
    visible: false,
    child: SizedBox(),
  );
}
