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
          "You May Like".text.size(18).bold.make().pSymmetric(v: 14, h: 4),
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 21 / 30.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: relatedApps.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleGridApp(
                rating: relatedApps[index]['rating'].toString(),
                seourl: relatedApps[index]['seourl'],
                name: relatedApps[index]['name'],
                icon: relatedApps[index]['icon'],
                starRating: relatedApps[index]['star_rating'].toString(),
              );
            },
          ),
        ],
      ).pOnly(left: 16, right: 16, top: 0, bottom: 14),
    );
  }
}
