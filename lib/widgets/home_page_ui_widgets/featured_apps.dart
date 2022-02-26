import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/featured_apps_animation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FeaturedApps extends StatefulWidget {
  const FeaturedApps({Key? key}) : super(key: key);

  @override
  State<FeaturedApps> createState() => _FeaturedAppsState();
}

class _FeaturedAppsState extends State<FeaturedApps> {
  List featuredApps = [];
  final String api =
      'https://api.apkdojo.com/v-apps.php?type=featured_apps&lang=en';

  fetchApps() async {
    var response = await Dio().get(api);
    return response.data['featured_apps'];
  }

  @override
  void initState() {
    fetchApps().then((value) {
      setState(() {
        featuredApps = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: null,
      height: 180,
      child: featuredApps.isNotEmpty
          ? GridView.builder(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 10 / 6,
                  mainAxisSpacing: 12),
              itemBuilder: (BuildContext context, int index) {
                return SingleVerticalApp(
                    seourl: featuredApps[index]['seourl'],
                    icon: featuredApps[index]['icon'],
                    name: featuredApps[index]['name'],
                    starRating: "${featuredApps[index]['star_rating']}");
              },
            )
          : const FeaturedAppAnimation(
              animatedItemCount: 3,
            ),
    );
  }
}
