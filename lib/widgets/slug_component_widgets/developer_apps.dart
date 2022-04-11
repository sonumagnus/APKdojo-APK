import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/featured_apps_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_custom_card_shadow.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

class DeveloperApps extends StatefulWidget {
  final String seourl;
  const DeveloperApps({Key? key, required this.seourl}) : super(key: key);

  @override
  _DeveloperAppsState createState() => _DeveloperAppsState();
}

class _DeveloperAppsState extends State<DeveloperApps> {
  late Future<List> developerApps;
  late DioCacheManager _dioCacheManager;

  Future<List> getDeveloperApps() async {
    _dioCacheManager = DioCacheManager(CacheConfig());

    Options _cacheOptions = buildCacheOptions(const Duration(days: 7));
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await _dio.get(
        'https://api.apkdojo.com/app-developer.php?id=${widget.seourl}',
        options: _cacheOptions);
    return response.data['developer_apps'];
  }

  @override
  void initState() {
    developerApps = getDeveloperApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlugCustomCardShadow(
      child: FutureBuilder<List>(
        future: developerApps,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: p20,
                    vertical: 15,
                  ),
                  child: Text(
                    snapshot.data![0]['developer'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: SizedBox(
                    height: 170,
                    child: ListView.builder(
                      itemExtent: 125,
                      clipBehavior: Clip.none,
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 12,
                          ),
                          child: SingleVerticalApp(
                            seourl: snapshot.data![index]['seourl'],
                            name: snapshot.data![index]['name'],
                            icon: snapshot.data![index]['icon'],
                            starRating:
                                snapshot.data![index]['star_rating'].toString(),
                            rating: snapshot.data![index]['rating'].toString(),
                          ),
                        );
                      },
                    ),
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
          return const Center(
            child: FeaturedAppAnimation(
              animatedItemCount: 3,
            ),
          );
        },
      ),
    );
  }
}



// Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             child: ListView(
//               physics: const ScrollPhysics(),
//               shrinkWrap: true,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10),
//                   child: Text(
//                     snapshot.data![0]['developer'],
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 GridView.builder(
//                   physics: const ScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       childAspectRatio: 10 / 14,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10),
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return SingleVerticalApp(
//                       seourl: snapshot.data![index]['seourl'],
//                       name: snapshot.data![index]['name'],
//                       icon: snapshot.data![index]['icon'],
//                       starRating:
//                           snapshot.data![index]['star_rating'].toString(),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           );