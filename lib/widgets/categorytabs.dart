import 'package:apkdojo/widgets/category_list.dart';
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
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
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
    final _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: basicAppBar(title: "Categories", context: context),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              color: Colors.transparent,
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 42,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200),
                    BoxShadow(
                      color: _textTheme.displayMedium!.color!,
                      spreadRadius: -1.0,
                      blurRadius: 1.0,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                ),
                child: TabBar(
                  controller: tabController,
                  unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
                  labelColor: Theme.of(context).tabBarTheme.labelColor,
                  padding: const EdgeInsets.all(4.0),
                  indicator: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
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
            SizedBox(
              width: _size.width,
              height: _size.height - _size.height / widget.mediaQueryHeightDivider,
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
    );
  }
}
