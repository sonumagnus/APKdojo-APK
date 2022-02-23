import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/widgets/home_page_ui_widgets/app_type.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/home_app_grid_animation.dart';
import 'package:apkdojo/widgets/star_rating.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class HomePageAppsGrid extends StatefulWidget {
  final String type;
  const HomePageAppsGrid({Key? key, required this.type}) : super(key: key);

  @override
  _HomePageAppsGridState createState() => _HomePageAppsGridState();
}

class _HomePageAppsGridState extends State<HomePageAppsGrid> {
  late Future<List> gridApps;

  Future<List> getGridApps() async {
    var response = await Dio().get(
        'https://api.apkdojo.com/v-apps.php?type=${widget.type}&lang=en',
        options: buildCacheOptions(const Duration(days: 7)));
    return response.data[widget.type];
  }

  @override
  void initState() {
    Dio().interceptors.add(DioCacheManager(CacheConfig(
            baseUrl:
                'https://api.apkdojo.com/v-apps.php?type=${widget.type}&lang=en'))
        .interceptor);
    gridApps = getGridApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppType(
            mainHeading: widget.type == 'new_apps' ? "New Apps" : "New Games",
            followUpText: "New Added & Updated",
            seeAllUrl: 'none',
            showSeeAll: true),
        FutureBuilder<List>(
          future: gridApps,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 4 / 6),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Slug(seourl: snapshot.data![index]['seourl']),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child:
                                  Image.network(snapshot.data![index]['icon'])),
                          Text(
                            snapshot.data![index]['name'],
                            maxLines: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StarRating(
                                rating:
                                    "${snapshot.data![index]['star_rating']}",
                                starSize: '11',
                              ),
                              Text(
                                snapshot.data![index]['rating'],
                                style: const TextStyle(fontSize: 10),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
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
