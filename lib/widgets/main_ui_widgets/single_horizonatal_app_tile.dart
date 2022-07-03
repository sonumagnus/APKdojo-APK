import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:velocity_x/velocity_x.dart';

class SingleHorizontalAppTile extends StatelessWidget {
  final String seourl, icon, name, developer;
  final bool showTrailing;
  const SingleHorizontalAppTile({
    Key? key,
    required this.seourl,
    required this.icon,
    required this.name,
    required this.developer,
    this.showTrailing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        ListTile(
          onTap: () => Navigator.of(context).push(
            createRouteRightToLeft(targetRoute: Slug(seourl: seourl)),
          ),
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          leading: Image(
            image: CachedNetworkImageProvider(icon),
            fit: BoxFit.fill,
          )
              .box
              .square(55)
              .clip(Clip.hardEdge)
              .margin(const EdgeInsets.only(right: 20))
              .color(_textTheme.displayMedium!.color!)
              .border(color: _textTheme.displayMedium!.color!)
              .withRounded(value: 12)
              .make(),
          title: name.text.size(15).medium.make(),
          subtitle: Html(
            data: developer,
            style: {
              "*": Style(
                margin: const EdgeInsets.only(top: 2),
                color: Theme.of(context).textTheme.titleSmall!.color,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            },
          ),
          trailing: Visibility(
              visible: showTrailing,
              child: "GET"
                  .text
                  .lg
                  .color(Colors.green.shade400)
                  .extraBold
                  .make()
                  .box
                  .color(Theme.of(context).textTheme.displayMedium!.color!)
                  .withRounded(value: 50)
                  .padding(const EdgeInsets.symmetric(horizontal: 25, vertical: 6))
                  .make()),
        ),
        const Divider(height: 2).pOnly(left: 65)
      ],
    ).pSymmetric(h: 20);
  }
}
