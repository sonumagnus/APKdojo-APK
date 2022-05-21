import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/dio_error_message.dart';
import 'package:apkdojo/widgets/home_page_ui_widgets/app_type.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/home_app_grid_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_grid_app.dart';
import 'package:apkdojo/widgets/new_added_n_updated_apps.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePageAppsGrid extends StatefulWidget {
  final String type;
  const HomePageAppsGrid({Key? key, required this.type}) : super(key: key);

  @override
  _HomePageAppsGridState createState() => _HomePageAppsGridState();
}

class _HomePageAppsGridState extends State<HomePageAppsGrid> {
  late Future<List> gridApps;

  Future<List> getGridApps() async {
    Response response = await Dio().get(
      'https://api.apkdojo.com/v-apps.php?type=${widget.type}&lang=en',
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
          showSeeAll: true,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: p20),
          child: FutureBuilder<List>(
            future: gridApps,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TopRoundedBorder(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleGridApp(
                        name: snapshot.data![index]['name'],
                        seourl: snapshot.data![index]['seourl'],
                        icon: snapshot.data![index]['icon'],
                        starRating: snapshot.data![index]['star_rating'].toString(),
                        rating: snapshot.data![index]['rating'].toString(),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const DioErrorMessage();
              }
              return const HomeAppGridAnimation(
                animatedItemCount: 8,
              );
            },
          ),
        ),
      ],
    );
  }
}

class TopRoundedBorder extends StatelessWidget {
  final Widget child;
  const TopRoundedBorder({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 0,
            color: Colors.amber.shade600,
            spreadRadius: 0,
            offset: const Offset(0, -1.5),
          ),
          const BoxShadow(
            blurRadius: 1,
            color: Colors.white,
            spreadRadius: 1 / 5,
            offset: Offset(0, 2),
          ),
          const BoxShadow(
            blurRadius: 1,
            color: Colors.white,
            spreadRadius: 1 / 5,
            offset: Offset(2, 0),
          ),
          const BoxShadow(
            blurRadius: 1,
            color: Colors.white,
            spreadRadius: 1 / 5,
            offset: Offset(-2, 0),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
