import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SlugScreenshot extends StatelessWidget {
  final int screenshotCount;
  final List screenshots;
  const SlugScreenshot(
      {Key? key, required this.screenshotCount, required this.screenshots})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 144,
      child: ListView.builder(
        itemCount: screenshotCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: CachedNetworkImage(
              imageUrl: screenshots[index],
            ),
          );
        },
      ),
    );
  }
}
