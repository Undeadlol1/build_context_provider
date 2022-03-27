import 'package:flutter/material.dart';
import 'package:build_context_provider/build_context_provider.dart';

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/first',
      routes: {
        '/first': (context) => const _Layout(child: _FirstScreen()),
        '/second': (context) => const _Layout(child: _SecondScreen()),
      },
    );
  }
}

class _FirstScreen extends StatelessWidget {
  const _FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('First screen'),
    );
  }
}

class _SecondScreen extends StatelessWidget {
  const _SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Second screen'),
    );
  }
}

class _Layout extends StatelessWidget {
  final Widget child;
  const _Layout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            const ListenerThatRunsFunctionsWithBuildContext(),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          child: const Text('Go to first screen'),
          onPressed: () => provideBuildContext(
            (context) => Navigator.pushNamed(context, '/first'),
          ),
        ),
        ElevatedButton(
          child: const Text('Go to second screen'),
          onPressed: () => provideBuildContext(
            (context) => Navigator.pushNamed(context, '/second'),
          ),
        ),
      ],
      floatingActionButton: const FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _displaySnackbar,
      ),
    );
  }
}

void _displaySnackbar() {
  provideBuildContext((context) {
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
          Text(
            'Function that creates this snackbar was called without a build context.',
          )
        ],
      ),
    );
  }
}

void main(List<String> args) {
  runApp(const _App());
}
