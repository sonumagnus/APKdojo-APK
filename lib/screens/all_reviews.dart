import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/widgets/dio_error_message.dart';
import 'package:apkdojo/widgets/main_ui_widgets/basic_app_bar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/write_reviews.dart';
import 'package:apkdojo/widgets/slug_component_widgets/reviews_list.dart';
import 'package:apkdojo/widgets/custom_status_bar.dart';
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
    return CustomStatusBar(
      child: SafeArea(
        child: Scaffold(
          appBar: basicAppBar(title: "Reviews", titleLeftSpacing: false),
          body: FutureBuilder<Map>(
            future: reviews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      WriteReviews(
                        name: snapshot.data!['name'],
                        icon: snapshot.data!['icon'],
                        appid: snapshot.data!['app_id'],
                        appurl: snapshot.data!['app_url'],
                        type: snapshot.data!['type'],
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!['reviews'] != null ? snapshot.data!['reviews'].length : 0,
                        itemBuilder: (BuildContext context, int index) {
                          return ReviewsList(
                            rating: snapshot.data!['reviews'][index]['rating'].toString(),
                            name: snapshot.data!['reviews'][index]['name'],
                            comment: snapshot.data!['reviews'][index]['comment'],
                            date: snapshot.data!['reviews'][index]['time'],
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
        ),
      ),
    );
  }
}
