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
  const SingleVerticalApp({
    Key? key,
    required this.seourl,
    required this.name,
    required this.icon,
    required this.starRating,
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreen, Colors.lightBlueAccent],
          ),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: icon,
                width: 80,
              ),
            ),
            Text(
              name,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.grey[800], overflow: TextOverflow.ellipsis),
            ),
            StarRating(
              rating: starRating,
              starSize: '14',
            ),
          ],
        ),
      ),
    );
  }
}
