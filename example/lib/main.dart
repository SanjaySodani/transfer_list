import 'package:flutter/material.dart';

import 'package:transfer_list/transfer_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Example',
      home: TransferListExample(),
    );
  }
}

class TransferListExample extends StatelessWidget {
  const TransferListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: TransferList(
            leftList: const ['Dog', 'Cat', 'Mouse', 'Rabbit', 'Sheep'],
            rightList: const ['Lion', 'Tiger', 'Cheetah', 'Wolf', 'Fox'],
            onChange: (leftList, rightList) {
              // your code
            },
            checkboxFillColor: Colors.amber,
            tileSplashColor: Colors.amber,
            listBackgroundColor: Colors.grey.shade200,
            textStyle: const TextStyle(color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
