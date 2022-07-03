import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Test extends HookWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 75,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
