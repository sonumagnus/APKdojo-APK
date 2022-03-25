import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/all_reviews.dart';
import 'package:apkdojo/widgets/slug_component_widgets/reviews_list.dart';
import 'package:flutter/material.dart';

ExpansionPanel userReviewsExpansionPanel(
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot, List<bool> _isOpen) {
  return ExpansionPanel(
      headerBuilder: (BuildContext context, _isOpen) {
        return const Text(
          "User Review",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        );
      },
      body: Builder(builder: (context) {
        return ListView(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
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
                    targetRoute: AllReviews(seourl: snapshot.data!['seourl']),
                  ),
                );
              },
              child: const Text("All Reviews"),
            )
          ],
        );
      }),
      isExpanded: _isOpen[0]);
}
