import 'package:apkdojo/widgets/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class WhatsNewExpansionPanel extends StatelessWidget {
  final Map<dynamic, dynamic>? appData;
  const WhatsNewExpansionPanel({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Accordion(
      title: "What's New",
      contentWidget: Html(
        data: appData!['whatsnew'],
        style: {
          "*": Style(
            fontSize: const FontSize(14),
            color: Colors.grey.shade500,
          )
        },
      ),
    );
  }
}
