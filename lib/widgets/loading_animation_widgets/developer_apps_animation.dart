import 'package:apkdojo/widgets/loading_animation_widgets/featured_apps_animation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class DeveloperAppsLoadingAnimation extends StatelessWidget {
  const DeveloperAppsLoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      Shimmer.fromColors(
        baseColor: Colors.cyan.shade100,
        highlightColor: Colors.grey.shade100,
        child: VxBox().size(120, 15).cyan400.rounded.margin(const EdgeInsets.only(left: 20, bottom: 30, top: 20)).make(),
      ),
      const FeaturedAppAnimation(animatedItemCount: 3)
    ].vStack(crossAlignment: CrossAxisAlignment.start);
  }
}
