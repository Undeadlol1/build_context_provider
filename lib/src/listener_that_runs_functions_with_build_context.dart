import 'package:flutter/widgets.dart';

import 'functions_stream_controller.dart';

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
        if (snapshot.hasData) {
          Future.microtask(() => snapshot.data!(context));
        }

        return _invisibleWidget;
      },
    );
  }

  static const _invisibleWidget = Visibility(
    visible: false,
    child: SizedBox(),
  );
}
