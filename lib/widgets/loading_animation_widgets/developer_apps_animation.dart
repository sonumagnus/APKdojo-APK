import 'package:apkdojo/widgets/loading_animation_widgets/featured_apps_animation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DeveloperAppsLoadingAnimation extends StatelessWidget {
  const DeveloperAppsLoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.cyan.shade100,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 20,
            ),
            height: 15,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        const FeaturedAppAnimation(
          animatedItemCount: 3,
        )
      ],
    );
  }
}
