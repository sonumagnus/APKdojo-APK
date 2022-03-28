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
    return SizedBox(
      height: 250,
      child: ListView.builder(
        // itemCount: snapshot.data!['screenshots'].length,
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
