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
  void dispose() {
    functionRunnerStream.close();
    super.dispose();
  }

  void _runFunctionWhenNotified(void Function(BuildContext)? functionToRun) {
    Future.microtask(
      () {
        functionToRun == null ? null : functionToRun(context);

        functionRunnerStream.add(null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: functionRunnerStream.stream,
      builder: (context, AsyncSnapshot<void Function(BuildContext)?> snapshot) {
        if (snapshot.hasData) {
          _runFunctionWhenNotified(snapshot.data);
          // snapshot.data();
        }

        return Visibility(
          visible: false,
          child: Container(),
        );
      },
    );
  }
}
