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
        mainHeading.text.size(16).extraBold.make(),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              followUpText.text.size(15).gray600.make(),
              Visibility(
                visible: showSeeAll,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.of(context).push(
                    createRouteRightToLeft(targetRoute: seeAllUrl),
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 22,
                    color: Colors.grey.shade700,
                  ),
                ).pOnly(right: 8),
              ),
            ],
          ),
        )
      ],
    ).pLTRB(p20, p20, p20, 10);
  }
}
