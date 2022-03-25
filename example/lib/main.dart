import 'package:flutter/material.dart';
import 'package:run_function_with_context_anywhere/run_function_with_context_anywhere.dart';

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: InvisibleListenerThatRunsFunctionsWithBuildContext(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _displaySnackbar,
        ),
      ),
    );
  }
}

void _displaySnackbar() {
  FunctionRunner.runFunction((context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: _Snackbar(),
      ),
    );
  });
}

class _Snackbar extends StatelessWidget {
  const _Snackbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: const [
          Text('If you see this snackbar then everything is working properly.'),
          Text('Function that creates this snackbar was called without a build context.')
        ],
      ),
    );
  }
}

void main(List<String> args) {
  runApp(const _App());
}
