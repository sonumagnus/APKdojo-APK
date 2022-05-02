import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 55,
                height: 55,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Image(
                  image: CachedNetworkImageProvider(
                    icon,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Html(
                data: developer,
                style: {
                  "*": Style(
                    margin: const EdgeInsets.only(top: 2),
                    color: Colors.grey.shade600,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                },
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 6,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 231, 231, 231),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: const Text(
                  "GET",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 89, 164, 4),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              horizontalTitleGap: 0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 65),
              child: Divider(
                height: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
