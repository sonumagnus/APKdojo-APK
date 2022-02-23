import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> text = [1, 2, 3, 4, 5, 6, 7];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test page"),
      ),
      body: Column(
        children: text.map((e) => Text(e.toString())).toList(),
      ),
    );
  }
}
