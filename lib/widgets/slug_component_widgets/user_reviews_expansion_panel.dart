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
              itemCount: snapshot.data!['reviews'].length,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AllReviews(seourl: snapshot.data!['seourl']),
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
