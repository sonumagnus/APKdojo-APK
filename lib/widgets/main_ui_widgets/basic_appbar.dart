import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget {
  const BasicAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white12,
      iconTheme: IconThemeData(
        color: Colors.grey.shade800,
      ),
    );
  }
}
