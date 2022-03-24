import 'package:flutter/material.dart';
import 'package:run_function_with_context_anywhere/run_function_with_context_anywhere.dart';

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const SingleChildScrollView(
          child: InvisibleListenerThatRunsFunctionsWithBuildContext(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}

void main(List<String> args) {
  runApp(const _App());
}
