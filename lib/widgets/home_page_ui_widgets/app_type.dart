import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:flutter/material.dart';

class AppType extends StatelessWidget {
  final String mainHeading;
  final String followUpText;
  final Widget seeAllUrl;
  final bool showSeeAll;
  const AppType(
      {Key? key,
      required this.mainHeading,
      required this.followUpText,
      required this.seeAllUrl,
      required this.showSeeAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainHeading,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  followUpText,
                  style: const TextStyle(fontSize: 15),
                ),
                if (showSeeAll)
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          createRouteRightToLeft(targetRoute: seeAllUrl),
                        );
                      },
                      child: const Text('See All'))
                else
                  const Text(''),
              ],
            ),
          )
        ],
      ),
    );
  }
}
