import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/custom_status_bar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';

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
    return CustomStatusBar(
      child: SafeArea(
        child: Scaffold(
          appBar: basicAppBar(title: "Categories"),
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
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TabBar(
                        unselectedLabelColor: Colors.green.shade500,
                        controller: tabController,
                        indicator: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: const BorderRadius.all(Radius.circular(0)),
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
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height - 220,
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / widget.mediaQueryHeightDivider,
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      CategoryList(type: "apps", cateListCount: "categoryLength"),
                      CategoryList(type: "games", cateListCount: "categoryLength"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
