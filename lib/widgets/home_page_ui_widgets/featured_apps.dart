import 'package:apkdojo/widgets/home_page_ui_widgets/app_type.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/featured_apps_animation.dart';
import 'package:apkdojo/widgets/new_added_n_updated_apps.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

class FeaturedApps extends StatefulWidget {
  const FeaturedApps({Key? key}) : super(key: key);

  @override
  State<FeaturedApps> createState() => _FeaturedAppsState();
}

class _FeaturedAppsState extends State<FeaturedApps> {
  late Future<List> featuredApps;
  late DioCacheManager _dioCacheManager;

  Future<List> fetchApps() async {
    _dioCacheManager = DioCacheManager(CacheConfig());

    Options _cacheOptions = buildCacheOptions(
      const Duration(days: 7),
      forceRefresh: true,
    );
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await _dio.get(
      'https://api.apkdojo.com/v-apps.php?type=featured_apps&lang=en',
      options: _cacheOptions,
    );
    return response.data['featured_apps'];
  }

  @override
  void initState() {
    super.initState();
    featuredApps = fetchApps();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: featuredApps,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const AppType(
                mainHeading: "Editor's Choice",
                followUpText: "Features By Apkdojo",
                seeAllUrl:
                    NewAddedAndUpdatedApps(applicationType: "featured_apps"),
                showSeeAll: true,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 170,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  itemExtent: 125,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // itemCount: snapshot.data!.length,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SingleVerticalApp(
                        seourl: snapshot.data![index]['seourl'],
                        name: snapshot.data![index]['name'],
                        icon: snapshot.data![index]['icon'],
                        starRating:
                            snapshot.data![index]['star_rating'].toString(),
                        rating: snapshot.data![index]['rating'],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              'fetching error ! Check Internet Connection',
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return const FeaturedAppAnimation(animatedItemCount: 3);
      },
    );
  }
}
