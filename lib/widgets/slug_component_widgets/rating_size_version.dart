import 'package:flutter/material.dart';

class RatingSizeVersionTable extends StatelessWidget {
  final String rating;
  final String size;
  final String version;
  const RatingSizeVersionTable(
      {Key? key,
      required this.rating,
      required this.size,
      required this.version})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(style: BorderStyle.solid),
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(rating),
                  const Text('Rating'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [Text(size), const Text('Size')]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(version),
                const Text("Version"),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
