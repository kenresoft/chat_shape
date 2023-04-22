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

A simple but very flexible and accommodating chat shape in flutter.
This can be of help as it can save the time needed to draw different chat-like shapes.
Different shapes have been accounted for programmatically in this simple package.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

 ```dart
Widget getShape() {
  ChatShapePainter(
    context: context,
    width: MediaQuery.of(context).size.width - 30,
    height: 200,
    color: Colors.indigo,
    applyTopRadius: true,
    enableHandle: true,
    handleHeight: 80,
    handleWidth: 100000,
    radius: 30,
    enableHandleCap: false,
    handle: HandleType.curved,
  );
}
 ```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
