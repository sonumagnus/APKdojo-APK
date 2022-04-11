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
          visualDensity: const VisualDensity(vertical: 2.0),
          title: Text(
            "Rate & Write Reviews for",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          subtitle: Text(
            widget.name,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: CachedNetworkImage(
              imageUrl: widget.icon,
              width: 44,
            ),
          ),
        ),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          itemSize: 28,
          allowHalfRating: false,
          itemCount: 5,
          unratedColor: Colors.grey.shade800,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star_border_sharp,
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
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                hintText: "Your Name",
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            TextField(
              onChanged: (value) {
                reviewDetails["comment"] = value;
              },
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                hintText: "Write Your Review Here",
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
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
                child: Text(
                  "Post Reviews",
                  style: TextStyle(color: Colors.green.shade500),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.cyan.shade50,
                  ),
                ),
              ),
            ),
            const Divider()
          ],
        )
      ],
    );
  }
}
