import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/all_reviews.dart';
import 'package:apkdojo/widgets/accordion.dart';
import 'package:apkdojo/widgets/slug_component_widgets/reviews_list.dart';
import 'package:flutter/material.dart';

class UserReviewsExpansionPanel extends StatelessWidget {
  final Map<dynamic, dynamic>? appData;
  const UserReviewsExpansionPanel({Key? key, required this.appData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Accordion(
      title: "User Reviews",
      contentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount:
                appData!['reviews'] != null ? appData!['reviews'].length : 0,
            itemBuilder: (BuildContext context, int index) {
              return ReviewsList(
                rating: appData!['reviews'][index]['rating'],
                name: appData!['reviews'][index]['name'],
                comment: appData!['reviews'][index]['comment'],
                date: appData!['reviews'][index]['time'],
                showDate: false,
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                createRouteRightToLeft(
                  targetRoute: AllReviews(seourl: appData!['seourl']),
                ),
              );
            },
            child: const Text(
              "All Reviews",
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).textTheme.displayMedium!.color,
              ),
            ),
          )
        ],
      ),
    );
  }
}
