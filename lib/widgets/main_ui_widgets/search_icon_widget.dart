import 'package:apkdojo/screens/search_page.dart';
import 'package:flutter/material.dart';

class SearchIconWidget extends StatelessWidget {
  const SearchIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchPage(),
          ),
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}
