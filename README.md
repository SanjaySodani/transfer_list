
A simple transfer list enables the user to move one or more list items to and fro.

## Features

![Transfer List demo](https://github.com/SanjaySodani/media/blob/main/transfer_list.gif "Demo")

## Getting started

* Add the package in your flutter project.
* Import the package `import 'package:transfer_list/transfer_list.dart';`.

## Usage

```dart
TransferList(
  leftList: const ['Dog', 'Cat', 'Mouse', 'Rabbit'],
  rightList: const ['Lion', 'Tiger', 'Fox' , 'Wolf'],
  onChange: (leftList, rightList) {
    // your logic
  },
  listBackgroundColor: Colors.black12,
  textStyle: const TextStyle(color: Colors.black),
),
```

## Parameters

| Parameter Name | Description |
| -------------- | ----------- |
| leftList | Initial items on left list |
| rightList | Initial items on right list |
| onChange | callback, passes new left and right list |
| checkboxFillColor | checkbox fill color |
| tileSplashColor | splash color on the list tile |
| listBackgroundColor | background color of the list containers |
| textStyle | text style of text on list tile |
| height | widget height |
| width | widget width |
