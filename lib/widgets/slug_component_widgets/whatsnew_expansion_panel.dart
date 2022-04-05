import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

ExpansionPanel whatsNewExpansionPanel(
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot, List<bool> _isOpen) {
  return ExpansionPanel(
    headerBuilder: (BuildContext context, isOpen) {
      return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: const Text(
          "What's New",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    },
    body: Html(
      data: snapshot.data!['whatsnew'],
    ),
    isExpanded: _isOpen[2],
  );
}
