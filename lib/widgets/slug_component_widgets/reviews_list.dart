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
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        rating,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if (showDate == true)
              Text(
                date,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            comment,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Divider(
          height: 15,
        )
      ],
    );
  }
}
