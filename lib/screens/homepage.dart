import 'dart:io';

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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  bool isOnline = true;

  _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup("example.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isOnline = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isOnline = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const MyAppBar(
        appBarTitle: "APKdojo",
      ),
      drawer: const MyDrawer(),
      body: !isOnline
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off_sharp),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "No Internet Connection",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: _checkInternetConnection,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: const Text("Refresh"),
                    ),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: const [
                  AppType(
                    mainHeading: "Editor's Choice",
                    followUpText: "Features By Apkdojo",
                    seeAllUrl: NewAddedAndUpdatedApps(
                        applicationType: "featured_apps"),
                    showSeeAll: true,
                  ),
                  FeaturedApps(),
                  HomePageAppsGrid(type: "new_apps"),
                  AppType(
                    mainHeading: "Top Categories",
                    followUpText: "Applications",
                    seeAllUrl: CategoryByTabs(selectedIndex: 0),
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
