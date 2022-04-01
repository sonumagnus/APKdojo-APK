import 'package:apkdojo/widgets/home_page_ui_widgets/app_type.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/home_app_grid_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_grid_app.dart';
import 'package:apkdojo/widgets/new_added_n_updated_apps.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

class HomePageAppsGrid extends StatefulWidget {
  final String type;
  const HomePageAppsGrid({Key? key, required this.type}) : super(key: key);

  @override
  _HomePageAppsGridState createState() => _HomePageAppsGridState();
}

class _HomePageAppsGridState extends State<HomePageAppsGrid> {
  late Future<List> gridApps;
  late DioCacheManager _dioCacheManager;

  Future<List> getGridApps() async {
    _dioCacheManager = DioCacheManager(CacheConfig());

    Options _cacheOptions = buildCacheOptions(
      const Duration(days: 7),
      forceRefresh: true,
    );
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await _dio.get(
      'https://api.apkdojo.com/v-apps.php?type=${widget.type}&lang=en',
      options: _cacheOptions,
    );
    return response.data[widget.type];
  }

  @override
  void initState() {
    super.initState();
    gridApps = getGridApps();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppType(
            mainHeading: widget.type == 'new_apps' ? "New Apps" : "New Games",
            followUpText: "New Added & Updated",
            seeAllUrl: NewAddedAndUpdatedApps(applicationType: widget.type),
            showSeeAll: true),
        FutureBuilder<List>(
          future: gridApps,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 10 / 16.8,
                ),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return SingleGridApp(
                      name: snapshot.data![index]['name'],
                      seourl: snapshot.data![index]['seourl'],
                      icon: snapshot.data![index]['icon'],
                      starRating:
                          snapshot.data![index]['star_rating'].toString(),
                      rating: snapshot.data![index]['rating'].toString());
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'fetching error ! Check Internet Connection',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return const HomeAppGridAnimation(
              animatedItemCount: 8,
            );
          },
        ),
      ],
    );
  }
}
