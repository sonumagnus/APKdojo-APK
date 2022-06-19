import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/providers/theme_provider.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/utils/calculation.dart';
import 'package:apkdojo/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SingleVerticalApp extends StatelessWidget {
  final String seourl, name, icon, starRating, rating;
  final int index;
  const SingleVerticalApp({
    Key? key,
    required this.seourl,
    required this.name,
    required this.icon,
    required this.starRating,
    required this.rating,
    required this.index,
  }) : super(key: key);

  static final List<Color> _lightColors = [
    const Color.fromRGBO(230, 247, 233, 1.0),
    const Color.fromRGBO(239, 246, 253, 1.0),
    const Color.fromRGBO(253, 242, 225, 1.0),
  ];

  static final List<Color> _darkColors = [
    const Color.fromRGBO(20, 41, 24, 1),
    const Color.fromRGBO(36, 41, 45, 1),
    const Color.fromRGBO(44, 41, 38, 1),
  ];

  @override
  Widget build(BuildContext context) {
    final getLightColor = _lightColors[Calculation.getNumberSequence(maxNumber: _lightColors.length, index: index)];

    final getDarkColor = _darkColors[Calculation.getNumberSequence(maxNumber: _lightColors.length, index: index)];

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          createRouteRightToLeft(targetRoute: Slug(seourl: seourl)),
        );
      },
      child: Consumer<ThemeProvider>(builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                placeholder: (context, url) => Image.asset(
                  'assets/images/lazy_images/lazy-image.jpg',
                ),
                imageUrl: icon,
                width: 85,
              ),
            ),
            name.text.size(12).medium.ellipsis.color(Theme.of(context).textTheme.labelMedium!.color).maxLines(2).make(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(rating: starRating, starSize: '9'),
                (rating == "null" ? "0.0" : rating).text.scale(0.6).make(),
              ],
            ),
          ],
        ).p(15).box.height(180).withRounded(value: 4).color(value.isDarkMode ? getDarkColor : getLightColor).make();
      }),
    );
  }
}
