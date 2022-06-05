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
BuildContextProvider.call(
    (context) => Navigator.pushNamed(context, '/somewhere'),
),
```

## Examples

```dart
class GoToProfilePage {
  static void call() {
    BuildContextProvider.call(
      (context) => Navigator.pushNamed(context, '/profile'),
    );
  }
}

// This line can be used anywhere. As you can see you are not tied to build context anymore.
GoToProfilePage.call();
```

## Tips

How does one use a value returned by the function? You must wrap your function and capture its result.

```dart
bool aValueToBeReturnedFromTheFunction = false;

bool functionThatReturnsValue(BuildContext context) {
  Navigator.of(context).pushNamed('/profile');
  return true;
}

void aFunctionThatCapturesReturnedValue(BuildContext context) {
  aValueToBeReturnedFromTheFunction = functionThatReturnsValue(context);
}

BuildContextProvider()(aFunctionThatCapturesReturnedValue);

expect(aValueToBeReturnedFromTheFunction, isTrue);
```

## Design Principles

1) No external libraries
2) Do a single thing and nothing else