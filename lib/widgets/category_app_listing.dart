import 'package:apkdojo/widgets/loading_animation_widgets/category_app_listing_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_horizonatal_app_tile.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class CategoryAppListing extends StatefulWidget {
  final String categoryName;
  final String applicationType;
  const CategoryAppListing(
      {Key? key, required this.categoryName, required this.applicationType})
      : super(key: key);

  @override
  State<CategoryAppListing> createState() => _CategoryAppListingState();
}

class _CategoryAppListingState extends State<CategoryAppListing> {
  late Future<List> apps;

  Future<List> getAppsList() async {
    var response = await Dio().get(
        'https://api.apkdojo.com/category.php?id=${widget.categoryName}&type=${widget.applicationType}&lang=en',
        options: buildCacheOptions(const Duration(days: 7)));
    return response.data['results'];
  }

  @override
  void initState() {
    Dio().interceptors.add(DioCacheManager(CacheConfig(
            baseUrl:
                'https://api.apkdojo.com/category.php?id=${widget.categoryName}&type=${widget.applicationType}&lang=en'))
        .interceptor);
    apps = getAppsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName.toUpperCase()),
      ),
      body: FutureBuilder<List>(
        future: apps,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleHorizontalAppTile(
                    seourl: snapshot.data![index]['seourl'],
                    icon: snapshot.data![index]['icon'],
                    name: snapshot.data![index]['name']);
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CategoryAppListingAnimation(
            animatedTileCount: 9,
          );
        },
      ),
    );
  }
}
