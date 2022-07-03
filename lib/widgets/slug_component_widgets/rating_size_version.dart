import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
      fontSize: 14,
      color: Theme.of(context).textTheme.labelMedium!.color,
    );

    TextStyle _keyDataStyling = TextStyle(
      fontSize: 15,
      color: Theme.of(context).textTheme.titleMedium!.color,
      fontWeight: FontWeight.w600,
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Colors.grey.shade200),
          bottom: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
      ),
      child: GridView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 1.2,
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
                ).pOnly(top: 5),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 1, color: Colors.grey.shade200),
                right: BorderSide(width: 1, color: Colors.grey.shade200),
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
                Text('Size', style: _keyOptionStyling).pOnly(top: 5),
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
              ).pOnly(top: 5),
            ]),
          ),
        ],
      ),
    );
  }
}
