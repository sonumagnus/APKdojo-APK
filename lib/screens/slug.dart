import 'package:apkdojo/main.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/slug_animation.dart';
import 'package:apkdojo/widgets/slug_component_widgets/apk_datail_expansion_panel.dart';
import 'package:apkdojo/widgets/slug_component_widgets/developer_apps.dart';
import 'package:apkdojo/widgets/slug_component_widgets/rating_size_version.dart';
import 'package:apkdojo/widgets/slug_component_widgets/related_apps.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_custom_card_shadow.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_description.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_icon_name_download_button.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_screenshot.dart';
import 'package:apkdojo/widgets/slug_component_widgets/user_review_expansion_panel.dart';
import 'package:apkdojo/widgets/slug_component_widgets/whats_new_expansion_panel.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Slug extends StatefulWidget {
  final String seourl;
  const Slug({Key? key, required this.seourl}) : super(key: key);

  @override
  State<Slug> createState() => _SlugState();
}

class _SlugState extends State<Slug> {
  late Future<Map> app;
  late DioCacheManager _dioCacheManager;

  Future<Map> fetchApp() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(
      const Duration(days: 3),
      forceRefresh: true,
    );
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await _dio.get(
      'https://api.apkdojo.com/app.php?id=${widget.seourl}&lang=en',
      options: _cacheOptions,
    );
    return response.data;
  }

  @override
  void initState() {
    setState(() {
      app = fetchApp();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        iconTheme: IconThemeData(color: iconThemeColor),
      ),
      body: FutureBuilder<Map>(
        future: app,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlugIconNameDownloadButton(
                    icon: snapshot.data!['icon'],
                    developer: snapshot.data!['developer'],
                    developerUrl: snapshot.data!['developer_url'],
                    name: snapshot.data!['name'],
                    seourl: snapshot.data!['seourl'],
                    apkurl: snapshot.data!['apkurl'],
                    playStoreUrl: snapshot.data!['playstore'],
                  ),
                  RatingSizeVersionTable(
                    rating: snapshot.data!['rating'].toString(),
                    size: snapshot.data!['size'],
                    version: snapshot.data!['version'],
                    totalRating: snapshot.data!['total_ratings'].toString(),
                  ),
                  SlugDescription(
                    description: snapshot.data!['des'],
                  ),
                  SlugScreenshot(
                    screenshotCount: snapshot.data!['screenshots'].length,
                    screenshots: snapshot.data!['screenshots'],
                  ),
                  SlugCustomCardShadow(
                    child: Column(
                      children: [
                        UserReviewsExpansionPanel(appData: snapshot.data),
                        ApkDetailsExpansionPanel(appData: snapshot.data),
                        WhatsNewExpansionPanel(appData: snapshot.data),
                      ],
                    ),
                  ),
                  DeveloperApps(seourl: snapshot.data!['seourl']),
                  RelatedApps(relatedApps: snapshot.data!['related'])
                ],
              ),
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
            child: SlugLoadingAnimation(),
          );
        },
      ),
    );
  }
}
