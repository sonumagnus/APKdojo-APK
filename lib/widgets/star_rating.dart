import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRating extends StatefulWidget {
  final String rating;
  const StarRating(this.rating, {Key? key}) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: double.parse(widget.rating) / 20,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 15,
        direction: Axis.horizontal,
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
        onRatingUpdate: (newRating) {
          // print(newRating);
        });
  }
}
