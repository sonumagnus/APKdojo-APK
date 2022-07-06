import 'package:apkdojo/screens/homepage.dart';
import 'package:apkdojo/screens/search_page.dart';
import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/download_manager_widgets/device_installed_apps.dart';
import 'package:apkdojo/widgets/download_manager_widgets/downloads.dart';
import 'package:apkdojo/widgets/main_ui_widgets/modern_dual_tabbar.dart';
import 'package:apkdojo/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late PageController pageController;

  static const List<Widget> _pages = [
    HomePage(),
    ModernDualTabBar(
      firstTabName: "Apps",
      secondTabName: "Games",
      firstChild: CategoryList(type: "apps", cateListCount: "categoryLength"),
      secondChild: CategoryList(
        type: "games",
        cateListCount: "categoryLength",
      ),
      keepBottomNavigatiorBarHeight: true,
      appBarTitle: "Categories",
    ),
    SearchPage(),
    ModernDualTabBar(
      firstTabName: "DOWNLOAD",
      secondTabName: "INSTALLED",
      firstChild: Downloads(),
      secondChild: DeviceInstalledApps(),
      appBarTitle: "Download Manager",
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Test(),
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex != 0
                ? SvgPicture.asset(
                    "assets/images/bottom_navigation_icons/home.svg",
                    color: Colors.grey.shade700,
                  )
                : SvgPicture.asset(
                    "assets/images/bottom_navigation_icons/home_active.svg",
                    color: Colors.green.shade400,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(Icons.grid_view_rounded)
                : SvgPicture.asset(
                    "assets/images/bottom_navigation_icons/grid_inactive.svg",
                    height: 22,
                    width: 22,
                  ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/search_icon.svg',
              height: 22,
              color: _selectedIndex == 2 ? Colors.green.shade400 : Colors.grey.shade700,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.symmetric(vertical: 3),
              padding: const EdgeInsets.only(bottom: 1),
              child: SvgPicture.asset(
                'assets/images/download.svg',
                height: 18,
                width: 18,
                color: _selectedIndex == 3 ? Colors.green.shade300 : Colors.grey.shade700,
                semanticsLabel: "download",
              ),
            ),
            label: 'Downloads',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green.shade300,
        onTap: _onItemTapped,
      ),
    ).box.white.make();
  }
}
