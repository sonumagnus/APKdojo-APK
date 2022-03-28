import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_appbar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class CategoryByTabs extends StatelessWidget {
  final int selectedIndex;
  const CategoryByTabs({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        appBarTitle: "Categories",
      ),
      drawer: const MyDrawer(),
      body: DefaultTabController(
        initialIndex: selectedIndex,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 5,
            bottom: const TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.grey,
              tabs: [
                Tab(text: 'Apps'),
                Tab(text: "Games"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              CategoryList(type: "apps", cateListCount: "categoryLength"),
              CategoryList(type: "games", cateListCount: "categoryLength"),
            ],
          ),
        ),
      ),
    );
  }
}
