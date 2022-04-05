import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/all_reviews.dart';
import 'package:apkdojo/widgets/slug_component_widgets/reviews_list.dart';
import 'package:flutter/material.dart';

ExpansionPanel userReviewsExpansionPanel(
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot, List<bool> _isOpen) {
  return ExpansionPanel(
      headerBuilder: (BuildContext context, _isOpen) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: const Text(
            "User Review",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: snapshot.data!['reviews'] != null
                      ? snapshot.data!['reviews'].length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ReviewsList(
                      rating: snapshot.data!['reviews'][index]['rating'],
                      name: snapshot.data!['reviews'][index]['name'],
                      comment: snapshot.data!['reviews'][index]['comment'],
                      date: snapshot.data!['reviews'][index]['time'],
                      showDate: false,
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      createRouteRightToLeft(
                        targetRoute:
                            AllReviews(seourl: snapshot.data!['seourl']),
                      ),
                    );
                  },
                  child: const Text(
                    "All Reviews",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.cyan.shade50,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      isExpanded: _isOpen[0]);
}
