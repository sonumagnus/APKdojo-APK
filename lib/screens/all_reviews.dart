import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/widgets/dio_error_message.dart';
import 'package:apkdojo/widgets/main_ui_widgets/basic_app_bar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/write_reviews.dart';
import 'package:apkdojo/widgets/slug_component_widgets/reviews_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AllReviews extends StatefulWidget {
  final String seourl;
  const AllReviews({Key? key, required this.seourl}) : super(key: key);

  @override
  AllReviewsState createState() => AllReviewsState();
}

class AllReviewsState extends State<AllReviews> {
  late Future<Map> reviews;

  Future<Map> getReviews() async {
    final String _api = '$apiDomain/reviews.php?app=${widget.seourl}';
    Response response = await Dio().get(_api);
    return response.data;
  }

  @override
  void initState() {
    reviews = getReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar(
        title: "Reviews",
        titleLeftSpacing: false,
        context: context,
      ),
      body: FutureBuilder<Map>(
        future: reviews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _app = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  WriteReviews(
                    name: _app['name'],
                    icon: _app['icon'],
                    appid: _app['app_id'],
                    appurl: _app['app_url'],
                    type: _app['type'],
                  ),
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _app['reviews'] != null
                        ? snapshot.data!['reviews'].length
                        : 0,
                    itemBuilder: (context, index) {
                      var _review = snapshot.data!['reviews'][index];
                      return ReviewsList(
                        rating: _review['rating'].toString(),
                        name: _review['name'],
                        comment: _review['comment'],
                        date: _review['time'],
                        showDate: true,
                      );
                    },
                  ).p12(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const DioErrorMessage();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
