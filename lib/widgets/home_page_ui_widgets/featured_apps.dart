import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/widgets/dio_error_message.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/featured_apps_animation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FeaturedApps extends StatefulWidget {
  const FeaturedApps({Key? key}) : super(key: key);

  @override
  State<FeaturedApps> createState() => _FeaturedAppsState();
}

class _FeaturedAppsState extends State<FeaturedApps> {
  late Future<List> _featuredApps;
  final String _api = '$apiDomain/v-apps.php?type=featured_apps&lang=en';

  Future<List> fetchApps() async {
    Response response = await Dio().get(_api);
    return response.data['featured_apps'];
  }

  @override
  void initState() {
    super.initState();
    _featuredApps = fetchApps();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _featuredApps,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              ListView.builder(
                clipBehavior: Clip.none,
                itemExtent: 125,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return SingleVerticalApp(
                    seourl: snapshot.data![index]['seourl'],
                    name: snapshot.data![index]['name'],
                    icon: snapshot.data![index]['icon'],
                    starRating: snapshot.data![index]['star_rating'].toString(),
                    rating: snapshot.data![index]['rating'],
                  ).pOnly(right: 10);
                },
              ).box.height(170).make().pSymmetric(h: 20),
            ],
          );
        } else if (snapshot.hasError) {
          return const DioErrorMessage();
        }
        return const FeaturedAppAnimation(animatedItemCount: 3);
      },
    );
  }
}
