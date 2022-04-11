import 'package:apkdojo/widgets/main_ui_widgets/single_grid_app.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_custom_card_shadow.dart';
import 'package:flutter/material.dart';

class RelatedApps extends StatelessWidget {
  final List relatedApps;
  const RelatedApps({Key? key, required this.relatedApps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlugCustomCardShadow(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 4,
              ),
              child: Text(
                "You May Like",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 10 / 16,
                crossAxisSpacing: 4,
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
        ),
      ),
    );
  }
}
