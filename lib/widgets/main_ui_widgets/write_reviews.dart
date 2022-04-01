import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReviews extends StatefulWidget {
  final String name;
  final String icon;
  final int appid;
  final String appurl;
  final String type;
  const WriteReviews({
    Key? key,
    required this.name,
    required this.icon,
    required this.appid,
    required this.appurl,
    required this.type,
  }) : super(key: key);

  @override
  State<WriteReviews> createState() => _WriteReviewsState();
}

class _WriteReviewsState extends State<WriteReviews> {
  Map<String, dynamic> reviewDetails = {};

  _postReview() async {
    var formData = FormData.fromMap(reviewDetails);
    // ignore: unused_local_variable
    Response response = await Dio().post(
      'https://api.apkdojo.com/post-review.php',
      data: formData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text("Rate & Write Reviews for"),
          subtitle: Text(widget.name),
          trailing: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: CachedNetworkImage(
              imageUrl: widget.icon,
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
            reviewDetails["rating"] = rating;
          },
        ),
        const Text("Tab a Star to Rate"),
        ListView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(15),
          shrinkWrap: true,
          children: [
            TextField(
              onChanged: (value) {
                reviewDetails["name"] = value;
              },
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), hintText: "Your Name"),
            ),
            TextField(
              onChanged: (value) {
                reviewDetails["comment"] = value;
              },
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Write Your Review Here"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ElevatedButton(
                  onPressed: () {
                    reviewDetails["appid"] = widget.appid;
                    reviewDetails["appurl"] = widget.appurl;
                    reviewDetails["type"] = widget.type;
                    reviewDetails["email"] = "abc@gamil.com";
                    _postReview();
                  },
                  child: const Text("Post Reviews")),
            ),
            const Divider()
          ],
        )
      ],
    );
  }
}
