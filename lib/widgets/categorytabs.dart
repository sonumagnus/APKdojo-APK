import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/main_ui_widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryByTabs extends StatefulWidget {
  final int selectedIndex;
  final double mediaQueryHeightDivider;
  const CategoryByTabs({
    Key? key,
    this.selectedIndex = 0,
    this.mediaQueryHeightDivider = 4.7,
  }) : super(key: key);

  @override
  State<CategoryByTabs> createState() => _CategoryByTabsState();
}

class _CategoryByTabsState extends State<CategoryByTabs> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: widget.selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: basicAppBar(title: "Categories", context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                color: Colors.transparent,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 42,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200),
                      BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: -1.0,
                        blurRadius: 1.0,
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                  ),
                  child: TabBar(
                    unselectedLabelColor: Vx.gray700,
                    controller: tabController,
                    labelColor: Vx.gray700,
                    padding: const EdgeInsets.all(4.0),
                    indicator: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: Colors.grey.shade200,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    tabs: const [
                      Tab(text: "Apps"),
                      Tab(text: "Games"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: _size.width,
              height: _size.height - _size.height / widget.mediaQueryHeightDivider,
              child: TabBarView(
                controller: tabController,
                children: const [
                  CategoryList(
                    type: "apps",
                    cateListCount: "categoryLength",
                  ),
                  CategoryList(
                    type: "games",
                    cateListCount: "categoryLength",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
