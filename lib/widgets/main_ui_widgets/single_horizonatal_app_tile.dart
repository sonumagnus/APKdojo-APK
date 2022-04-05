import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleHorizontalAppTile extends StatelessWidget {
  final String seourl;
  final String icon;
  final String name;
  final String developer;
  const SingleHorizontalAppTile({
    Key? key,
    required this.seourl,
    required this.icon,
    required this.name,
    required this.developer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            createRouteRightToLeft(
              targetRoute: Slug(seourl: seourl),
            ),
          );
        },
        child: Column(
          children: [
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              minVerticalPadding: 0,
              leading: Image(
                image: CachedNetworkImageProvider(icon),
                height: 44,
                width: 44,
              ),
              title: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  developer,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: const Text(
                  "Download",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
            ),
            const Divider(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
