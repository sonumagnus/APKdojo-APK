import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppType extends StatelessWidget {
  final String mainHeading;
  final String followUpText;
  final Widget seeAllUrl;
  final bool showSeeAll;
  const AppType({
    Key? key,
    required this.mainHeading,
    required this.followUpText,
    this.seeAllUrl = const SizedBox.shrink(),
    required this.showSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainHeading.text.size(16).color(Theme.of(context).textTheme.titleLarge!.color).extraBold.make(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            followUpText.text.size(15).color(Theme.of(context).textTheme.titleSmall!.color).make(),
            Visibility(
              visible: showSeeAll,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.of(context).push(
                  createRouteRightToLeft(targetRoute: seeAllUrl),
                ),
                icon: const Icon(Icons.arrow_forward, size: 22),
              ).pOnly(right: 8),
            ),
          ],
        ).pOnly(top: 4)
      ],
    ).pLTRB(p20, p20, p20, 10);
  }
}
