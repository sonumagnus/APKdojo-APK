import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/search_page.dart';
import 'package:flutter/material.dart';

appBar(height, context, _scaffoldKey) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, height + 8),
    child: Stack(
      children: <Widget>[
        Positioned(
          // To take AppBar Size only
          top: 40.0,
          left: 20.0,
          right: 20.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                createRouteRightToLeft(
                  targetRoute: const SearchPage(),
                ),
              );
            },
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
        )
      ],
    ),
  );
}
