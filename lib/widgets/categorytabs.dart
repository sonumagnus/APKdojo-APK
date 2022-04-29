import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_appbar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class CategoryByTabs extends StatelessWidget {
  final int selectedIndex;
  const CategoryByTabs({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(appBarTitle: "Categories"),
      drawer: const MyDrawer(),
      body: DefaultTabController(
        initialIndex: selectedIndex,
        length: 2,
        child: Container(
          padding: EdgeInsets.all(p20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade200,
              toolbarHeight: 0,
              bottom: TabBar(
                indicator: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade300,
                ),
                labelColor: Colors.black,
                indicatorColor: Colors.white,
                tabs: const [
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
      ),
    );
  }
}
