import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SlugDescription extends StatelessWidget {
  final String description;
  const SlugDescription({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(data: description);
  }
}
