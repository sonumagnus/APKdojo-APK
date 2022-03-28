import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
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
    return FutureBuilder<List>(
      future: developerApps,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  snapshot.data![0]['developer'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: 125,
                      child: SingleVerticalApp(
                        seourl: snapshot.data![index]['seourl'],
                        name: snapshot.data![index]['name'],
                        icon: snapshot.data![index]['icon'],
                        starRating:
                            snapshot.data![index]['star_rating'].toString(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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