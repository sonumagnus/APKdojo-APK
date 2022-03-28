import 'package:apkdojo/widgets/main_ui_widgets/write_reviews.dart';
import 'package:apkdojo/widgets/slug_component_widgets/reviews_list.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

class AllReviews extends StatefulWidget {
  final String seourl;
  const AllReviews({Key? key, required this.seourl}) : super(key: key);

  @override
  AllReviewsState createState() => AllReviewsState();
}

class AllReviewsState extends State<AllReviews> {
  late Future<Map> reviews;
  late DioCacheManager _dioCacheManager;

  Future<Map> getReviews() async {
    _dioCacheManager = DioCacheManager(CacheConfig());

    Options _cacheOptions = buildCacheOptions(const Duration(days: 7));
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    var response = await _dio.get(
        'https://api.apkdojo.com/reviews.php?app=${widget.seourl}',
        options: _cacheOptions);
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
      appBar: AppBar(
        title: Text(widget.seourl),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map>(
          future: reviews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  WriteReviews(
                      name: snapshot.data!['name'],
                      icon: snapshot.data!['icon']),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!['reviews'] != null
                          ? snapshot.data!['reviews'].length
                          : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return ReviewsList(
                          rating: snapshot.data!['reviews'][index]['rating']
                              .toString(),
                          name: snapshot.data!['reviews'][index]['name'],
                          comment: snapshot.data!['reviews'][index]['comment'],
                          date: snapshot.data!['reviews'][index]['time'],
                          showDate: true,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
