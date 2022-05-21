import 'package:flutter/material.dart';

class RatingSizeVersionTable extends StatelessWidget {
  final String rating;
  final String size;
  final String version;
  final String totalRating;
  const RatingSizeVersionTable({
    Key? key,
    required this.rating,
    required this.size,
    required this.version,
    required this.totalRating,
  }) : super(key: key);

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
        physics: const ScrollPhysics(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rating != "null" ? rating : 0.0.toString(),
                      style: _keyDataStyling,
                    ),
                    const Icon(Icons.star, size: 14, color: Colors.amber)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      totalRating != "null" ? "$totalRating " : "0",
                      style: _keyOptionStyling,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('Rating', style: _keyOptionStyling),
                  ],
                ),
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
                Text(
                  size,
                  style: _keyDataStyling,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('Size', style: _keyOptionStyling),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(children: [
              Text(
                version,
                style: _keyDataStyling,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Version",
                style: _keyOptionStyling,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
