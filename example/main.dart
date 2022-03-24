import 'package:flutter/material.dart';

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SingleChildScrollView(
        child: Scaffold(
          body: Container(),
          floatingActionButton: FloatingActionButton(
            child: const Text('+'),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

void main(List<String> args) {
  runApp(const _App());
}
