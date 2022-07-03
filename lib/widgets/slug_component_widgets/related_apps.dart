import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_grid_app.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_custom_card_shadow.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RelatedApps extends StatelessWidget {
  final List relatedApps;
  const RelatedApps({Key? key, required this.relatedApps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlugCustomCardShadow(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "You May Like".text.size(18).bold.color(Theme.of(context).textTheme.titleMedium!.color).make().pSymmetric(v: 14, h: 4),
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 21 / 32,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: relatedApps.length,
            itemBuilder: (context, index) {
              final app = relatedApps[index];
              return SingleGridApp(
                rating: app['rating'].toString(),
                seourl: app['seourl'],
                name: app['name'],
                icon: app['icon'],
                starRating: app['star_rating'].toString(),
              );
            },
          ),
        ],
      ).pOnly(left: p20, right: p20, top: 0, bottom: p20),
    );
  }
}
