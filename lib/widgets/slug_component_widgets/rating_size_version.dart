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
    TextStyle _keyOptionStyling = TextStyle(
      fontSize: 12,
      color: Colors.grey.shade500,
    );

    TextStyle _keyDataStyling = TextStyle(
      fontSize: 14,
      color: Colors.grey.shade700,
      fontWeight: FontWeight.bold,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Colors.grey.shade300),
          bottom: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
      ),
      child: GridView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 1,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                Text(rating != "null" ? rating : 0.0.toString(),
                    style: _keyDataStyling),
                Text('Rating', style: _keyOptionStyling),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 1, color: Colors.grey.shade300),
                right: BorderSide(width: 1, color: Colors.grey.shade300),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                Text(size, style: _keyDataStyling),
                Text('Size', style: _keyOptionStyling),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(children: [
              Text(version, style: _keyDataStyling),
              Text("Version", style: _keyOptionStyling),
            ]),
          ),
        ],
      ),
    );
  }
}
