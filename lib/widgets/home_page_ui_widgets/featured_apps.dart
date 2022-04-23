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
  late Future<List> featuredApps;

  Future<List> fetchApps() async {
    Response response = await Dio().get(
      'https://api.apkdojo.com/v-apps.php?type=featured_apps&lang=en',
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
