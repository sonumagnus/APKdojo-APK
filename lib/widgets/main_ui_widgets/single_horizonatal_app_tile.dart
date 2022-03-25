import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:flutter/material.dart';

class SingleHorizontalAppTile extends StatelessWidget {
  final String seourl;
  final String icon;
  final String name;
  const SingleHorizontalAppTile(
      {Key? key, required this.seourl, required this.icon, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            createRouteRightToLeft(
              targetRoute: Slug(seourl: seourl),
            ),
          );
        },
        child: ListTile(
            leading: Image.network(
              icon,
              height: 45,
            ),
            title: Text(name),
            trailing: const Icon(
              Icons.download,
              size: 30,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5)),
      ),
    );
  }
}
