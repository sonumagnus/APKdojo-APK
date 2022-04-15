import 'package:apkdojo/widgets/categorytabs.dart';
import 'package:apkdojo/widgets/home_page_ui_widgets/app_type.dart';
import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/home_page_ui_widgets/home_app_grid.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_appbar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:apkdojo/widgets/new_added_n_updated_apps.dart';
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
    return Scaffold(
      appBar: const MyAppBar(
        appBarTitle: "APKdojo",
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AppType(
              mainHeading: "Editor's Choice",
              followUpText: "Features By Apkdojo",
              seeAllUrl:
                  NewAddedAndUpdatedApps(applicationType: "featured_apps"),
              showSeeAll: true,
            ),
            FeaturedApps(),
            HomePageAppsGrid(type: "new_apps"),
            AppType(
              mainHeading: "Top Categories",
              followUpText: "Applications",
              seeAllUrl: CategoryByTabs(
                selectedIndex: 0,
              ),
              showSeeAll: true,
            ),
            CategoryList(type: 'apps', cateListCount: '6'),
            HomePageAppsGrid(type: "new_games"),
            AppType(
                mainHeading: "Top Categories",
                followUpText: "Games",
                seeAllUrl: CategoryByTabs(selectedIndex: 1),
                showSeeAll: true),
            CategoryList(type: 'games', cateListCount: '6'),
          ],
        ),
      ),
    );
  }
}
