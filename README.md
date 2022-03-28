<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
A package that allows you to run functions that require BuildContext outside of Flutter widgets.

## Installation

* Drop ListenerThatRunsFunctionsWithBuildContext() somewhere in the application. It is best to place it in the root of the app.
```dart
    return Column(
          children: [
            child,
            const ListenerThatRunsFunctionsWithBuildContext(),
          ],
      ),
```

## Usage

Wrap any functions that you want to run with a provider:

```dart
provideBuildContext(
    (context) => Navigator.pushNamed(context, '/somewhere'),
),
```
or
```dart
BuildContextProvider.provideBuildContext(
    (context) => Navigator.pushNamed(context, '/somewhere'),
),
```

## Examples:

```dart
class GoToProfilePage {
  static void call() {
    provideBuildContext(
      (context) => Navigator.pushNamed(context, '/profile'),
    );
  }
}

// This line can be used anywhere. As you can see there you are not tied to build context anymore.
GoToProfilePage.call();
```