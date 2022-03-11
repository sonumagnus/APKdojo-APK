import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/widgets/star_rating.dart';
import 'package:flutter/material.dart';

class SingleGridApp extends StatelessWidget {
  final String name;
  final String icon;
  final String seourl;
  final String starRating;
  final String rating;
  const SingleGridApp(
      {Key? key,
      required this.name,
      required this.icon,
      required this.seourl,
      required this.starRating,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Slug(seourl: seourl),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(icon),
            ),
            Text(
              name,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StarRating(
                  rating: starRating,
                  starSize: '11',
                ),
                Text(
                  rating == "null" ? "0.0" : rating,
                  style: const TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}