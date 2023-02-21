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

A transfer list enables the user to move one or more list items to and fro.

## Getting started

* Add the package in your flutter project.
* Import the package `import 'package:transfer_list/transfer_list.dart';`.

## Usage

```dart
TransferList(
  leftList: const ['Dog', 'Cat', 'Mouse', 'Rabbit'],
  rightList: const [],
  onChange: (leftList, rightList) {
    // your logic
  },
  listBackgroundColor: Colors.black12,
  textStyle: const TextStyle(color: Colors.black),
),
```
