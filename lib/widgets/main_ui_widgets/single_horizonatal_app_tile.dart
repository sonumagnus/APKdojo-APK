import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:velocity_x/velocity_x.dart';

class SingleHorizontalAppTile extends StatelessWidget {
  final String seourl, icon, name, developer;
  const SingleHorizontalAppTile({
    Key? key,
    required this.seourl,
    required this.icon,
    required this.name,
    required this.developer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          createRouteRightToLeft(targetRoute: Slug(seourl: seourl)),
        );
      },
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            leading: Image(
              image: CachedNetworkImageProvider(icon),
              fit: BoxFit.fill,
            ).box.square(55).clip(Clip.hardEdge).margin(const EdgeInsets.only(right: 20)).white.border(color: Vx.gray300).withRounded(value: 12).make(),
            title: name.text.size(15).medium.make(),
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
            trailing: "GET".text.lg.green600.extraBold.make().box.color(Colors.grey.shade200).withRounded(value: 50).padding(const EdgeInsets.symmetric(horizontal: 25, vertical: 6)).make(),
          ),
          const Divider(height: 2).pOnly(left: 65)
        ],
      ),
    ).pSymmetric(h: 20);
  }
}
