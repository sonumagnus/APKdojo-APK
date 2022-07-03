import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/widgets/dio_error_message.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/developer_apps_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_custom_card_shadow.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DeveloperApps extends StatefulWidget {
  final String seourl;
  const DeveloperApps({Key? key, required this.seourl}) : super(key: key);

  @override
  _DeveloperAppsState createState() => _DeveloperAppsState();
}

class _DeveloperAppsState extends State<DeveloperApps> {
  late Future<List> developerApps;

  Future<List> getDeveloperApps() async {
    final String _api = '$apiDomain/app-developer.php?id=${widget.seourl}';
    Response response = await Dio().get(_api);
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: FutureBuilder<List>(
        future: developerApps,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "${snapshot.data![0]['developer']}".text.size(18).bold.color(Theme.of(context).textTheme.titleMedium!.color).make().pSymmetric(h: 20, v: 15),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                    itemExtent: 125,
                    clipBehavior: Clip.none,
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final app = snapshot.data![index];
                      return SingleVerticalApp(
                        seourl: app['seourl'],
                        name: app['name'],
                        icon: app['icon'],
                        starRating: app['star_rating'].toString(),
                        rating: app['rating'].toString(),
                        index: index,
                      ).pOnly(right: 12);
                    },
                  ),
                ).pSymmetric(h: 20, v: 12),
              ],
            );
          } else if (snapshot.hasError) {
            return const DioErrorMessage();
          }
          return const DeveloperAppsLoadingAnimation();
        },
      ),
    );
  }
}
