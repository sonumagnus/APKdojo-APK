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
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
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
                    color: Colors.grey.shade700,
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
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: const [
                          Text(
                            'See All',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 16,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
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
