import 'package:apkdojo/widgets/category_list.dart';
import 'package:flutter/material.dart';

class CategoryByTabs extends StatelessWidget {
  const CategoryByTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 5,
          bottom: const TabBar(
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
    );
  }
}
