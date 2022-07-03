import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ReviewsList extends StatelessWidget {
  final String rating, name, comment, date;
  final bool showDate;
  const ReviewsList({
    Key? key,
    required this.rating,
    required this.name,
    required this.comment,
    required this.date,
    required this.showDate,
  }) : super(key: key);

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
                Row(
                  children: [
                    rating.text.white.size(12).bold.make(),
                    const Icon(Icons.star, size: 12, color: Colors.white),
                  ],
                ).box.color(Colors.green.shade300).withRounded(value: 3).margin(const EdgeInsets.only(right: 8)).padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 2)).make(),
                name.text.medium.color(Theme.of(context).textTheme.titleMedium!.color).make(),
              ],
            ),
            if (showDate) date.text.size(12).color(Colors.grey.shade600).make()
          ],
        ),
        comment.text.size(12).color(Colors.grey.shade600).medium.make().pOnly(top: 8),
        const Divider(height: 15)
      ],
    );
  }
}
