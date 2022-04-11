import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: EdgeInsets.only(
        top: 22,
        left: p20,
        right: p20,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainHeading,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  followUpText,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (showSeeAll)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        createRouteRightToLeft(targetRoute: seeAllUrl),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 3,
                        bottom: 3,
                        right: 3,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Icon(
                            Icons.navigate_next,
                            size: 16,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  )
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
