import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SingleVerticalApp extends StatelessWidget {
  final String seourl;
  final String name;
  final String icon;
  final String starRating;
  final String rating;
  const SingleVerticalApp({
    Key? key,
    required this.seourl,
    required this.name,
    required this.icon,
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
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreen.shade200, Colors.blue.shade100],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: icon,
                width: 85,
              ),
            ),
            Text(
              name,
              maxLines: 2,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(
                  rating: starRating,
                  starSize: '9',
                ),
                Text(
                  rating,
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey.shade800,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
