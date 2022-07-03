import 'package:apkdojo/providers/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlugScreenshot extends StatelessWidget {
  final List screenshots;
  const SlugScreenshot({
    Key? key,
    required this.screenshots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          height: 240,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            // boxShadow: [
            //   const BoxShadow(
            //     blurRadius: 5,
            //     spreadRadius: 1,
            //     color: Colors.black12,
            //     offset: Offset(0, 1),
            //   ),
            //   BoxShadow(
            //     blurRadius: 5,
            //     spreadRadius: 1,
            //     color: value.isDarkMode ? Colors.grey.shade900 : Colors.white,
            //     offset: const Offset(0, -5),
            //   ),
            // ],
          ),
          child: ListView.builder(
            clipBehavior: Clip.none,
            itemCount: screenshots.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Container(
              margin: const EdgeInsets.only(right: 10),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: CachedNetworkImage(
                placeholder: (context, url) => Image.asset(
                  "assets/images/lazy_images/lazy-screen.jpg",
                ),
                imageUrl: screenshots[index],
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}
