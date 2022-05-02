import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/main_ui_widgets/custom_appbar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class CategoryByTabs extends StatefulWidget {
  final int selectedIndex;
  final double mediaQueryHeightDivider;
  const CategoryByTabs({
    Key? key,
    this.selectedIndex = 0,
    this.mediaQueryHeightDivider = 3.5,
  }) : super(key: key);

  @override
  State<CategoryByTabs> createState() => _CategoryByTabsState();
}

class _CategoryByTabsState extends State<CategoryByTabs>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(AppBar().preferredSize.height, context, _scaffoldKey),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.transparent,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  // margin: const EdgeInsets.all(20),
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
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height /
                      widget.mediaQueryHeightDivider,
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


// class CategoryByTabs extends StatelessWidget {
//   final int selectedIndex;
//   const CategoryByTabs({
//     Key? key,
//     required this.selectedIndex,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MyAppBar(appBarTitle: "Categories"),
//       drawer: const MyDrawer(),
//       body: DefaultTabController(
//         initialIndex: selectedIndex,
//         length: 2,
//         child: Container(
//           padding: EdgeInsets.all(p20),
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(12)),
//           ),
//           child: Scaffold(
//             appBar: AppBar(
//               elevation: 0,
//               backgroundColor: Colors.grey.shade200,
//               toolbarHeight: 0,
//               bottom: TabBar(
//                 indicator: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   color: Colors.grey.shade300,
//                 ),
//                 labelColor: Colors.black,
//                 indicatorColor: Colors.white,
//                 tabs: const [
//                   Tab(text: 'Apps'),
//                   Tab(text: "Games"),
//                 ],
//               ),
//             ),
//             body: const TabBarView(
//               children: [
//                 CategoryList(type: "apps", cateListCount: "categoryLength"),
//                 CategoryList(type: "games", cateListCount: "categoryLength"),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
