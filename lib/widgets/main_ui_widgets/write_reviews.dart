import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReviews extends StatelessWidget {
  final String name;
  final String icon;
  const WriteReviews({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text("Rate & Write Reviews for"),
          subtitle: Text(name),
          trailing: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: CachedNetworkImage(
              imageUrl: icon,
              width: 40,
            ),
          ),
        ),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            //  print(rating);
          },
        ),
        const Text("Tab a Star to Rate"),
        ListView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(15),
          shrinkWrap: true,
          children: [
            const TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: "Your Name"),
            ),
            const TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Write Your Review Here"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Post Reviews")),
            ),
            const Divider()
          ],
        )
      ],
    );
  }
}
