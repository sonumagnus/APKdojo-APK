import 'package:apkdojo/screens/download_manager.dart';
import 'package:apkdojo/screens/homepage.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:apkdojo/widgets/categorytabs.dart';
// import 'package:apkdojo/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    CategoryByTabs(
      selectedIndex: 0,
    ),
    DownloadManager(),
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
      drawer: const MyDrawer(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/download.svg',
              height: 18,
              width: 18,
              color: Colors.grey.shade700,
              semanticsLabel: "download",
            ),
            label: 'Downloads',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green.shade300,
        onTap: _onItemTapped,
      ),
    );
  }
}
