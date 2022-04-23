import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SlugScreenshot extends StatelessWidget {
  final int screenshotCount;
  final List screenshots;
  const SlugScreenshot({
    Key? key,
    required this.screenshotCount,
    required this.screenshots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 164,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            color: Colors.black12,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            color: Colors.white,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: screenshotCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: CachedNetworkImage(
                placeholder: (context, url) => Image.asset(
                  "assets/images/lazy_images/lazy-screen.jpg",
                ),
                imageUrl: screenshots[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
