import 'package:apkdojo/widgets/home_page_ui_widgets/app_type.dart';
import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/home_page_ui_widgets/home_app_grid.dart';
import 'package:apkdojo/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:apkdojo/widgets/home_page_ui_widgets/featured_apps.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        shrinkWrap: true,
        children: const [
          Test(),
          AppType(
            mainHeading: "Editor's Choice",
            followUpText: "Features By Apkdojo",
            seeAllUrl: 'none',
            showSeeAll: true,
          ),
          FeaturedApps(),
          HomePageAppsGrid(type: "new_apps"),
          AppType(
              mainHeading: "Top Categories",
              followUpText: "Apps",
              seeAllUrl: "None",
              showSeeAll: true),
          CategoryList(type: 'apps', cateListCount: '6'),
          HomePageAppsGrid(type: "new_games"),
          AppType(
              mainHeading: "Top Categories",
              followUpText: "Games",
              seeAllUrl: "none",
              showSeeAll: true),
          CategoryList(type: 'games', cateListCount: '6'),
        ],
      ),
    );
  }
}
