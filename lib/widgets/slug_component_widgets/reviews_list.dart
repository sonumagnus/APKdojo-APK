import 'package:flutter/material.dart';

class ReviewsList extends StatelessWidget {
  final String rating;
  final String name;
  final String comment;
  final String date;
  final bool showDate;
  const ReviewsList(
      {Key? key,
      required this.rating,
      required this.name,
      required this.comment,
      required this.date,
      required this.showDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        rating,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Icon(Icons.star, size: 15, color: Colors.white),
                    ],
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (showDate == true) Text(date),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
          child: Text(comment),
        ),
        const Divider()
      ],
    );
  }
}
