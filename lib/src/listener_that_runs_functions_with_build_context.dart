import 'dart:async';

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
  @override
  void dispose() async {
    await funcstionsStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (funcstionsStreamController.hasListener) {
      return _invisibleWidget;
    }

    return StreamBuilder(
      stream: funcstionsStreamController.stream,
      builder: (context, AsyncSnapshot<void Function(BuildContext)?> snapshot) {
        if (snapshot.hasData) {
          _runFunctionWhenNotified(
            buildContext: context,
            functionToRun: snapshot.data,
          );
        }

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
