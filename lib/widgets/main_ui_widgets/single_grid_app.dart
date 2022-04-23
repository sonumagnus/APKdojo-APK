import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/widgets/star_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleGridApp extends StatelessWidget {
  final String name;
  final String icon;
  final String seourl;
  final String starRating;
  final String rating;
  const SingleGridApp({
    Key? key,
    required this.name,
    required this.icon,
    required this.seourl,
    required this.starRating,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          createRouteRightToLeft(
            targetRoute: Slug(seourl: seourl),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(7.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => Image.asset(
                  "assets/images/lazy_images/lazy-image.jpg",
                ),
                imageUrl: icon,
                height: 68.33,
                width: 68.33,
              ),
            ),
            Text(
              name,
              maxLines: 2,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StarRating(
                  rating: starRating,
                  starSize: '9',
                ),
                Text(
                  rating == "null" ? "0.0" : rating,
                  style: const TextStyle(fontSize: 9),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
