import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DioErrorMessage extends StatelessWidget {
  final String message;
  const DioErrorMessage({Key? key, this.message = 'fetching error ! Check Internet Connection'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return message.text.size(16).makeCentered();
  }
}
