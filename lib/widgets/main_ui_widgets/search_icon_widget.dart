import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/search_page.dart';
import 'package:flutter/material.dart';

class SearchIconWidget extends StatelessWidget {
  const SearchIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          createRouteRightToLeft(
            targetRoute: const SearchPage(),
          ),
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}
