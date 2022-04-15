import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRating extends StatefulWidget {
  final String rating;
  final String starSize;
  const StarRating({Key? key, required this.rating, required this.starSize})
      : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: double.parse(widget.rating) / 20,
      allowHalfRating: true,
      ignoreGestures: true,
      itemCount: 5,
      itemSize: double.parse(widget.starSize),
      direction: Axis.horizontal,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
      onRatingUpdate: (newRating) {
        // print(newRating);
      },
    );
  }
}
