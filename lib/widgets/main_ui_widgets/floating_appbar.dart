import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class FloatingAppBar extends StatefulWidget {
  final Widget child;
  const FloatingAppBar({
    Key? key,
    this.child = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  State<FloatingAppBar> createState() => _FloatingAppBarState();
}

class _FloatingAppBarState extends State<FloatingAppBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const MyDrawer(),
        body: Stack(
          children: [
            widget.child,
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       const SizedBox(height: 50),
            //       child,
            //     ],
            //   ),
            // ),
            Positioned(
              top: 8.0,
              left: 20.0,
              right: 20.0,
              child: GestureDetector(
                onTap: () {},
                child: AppBar(
                  elevation: 1,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  primary: false,
                  title: Text(
                    "Search for apps & games",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
