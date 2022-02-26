import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

ExpansionPanel whatsNewExpansionPanel(
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot, List<bool> _isOpen) {
  return ExpansionPanel(
      headerBuilder: (BuildContext context, isOpen) {
        return const Text(
          "What's New",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        );
      },
      body: Html(
        data: snapshot.data!['whatsnew'],
      ),
      isExpanded: _isOpen[2]);
}
