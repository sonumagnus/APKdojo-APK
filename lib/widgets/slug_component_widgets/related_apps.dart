import 'package:apkdojo/widgets/main_ui_widgets/single_grid_app.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
import 'package:flutter/material.dart';

class RelatedApps extends StatelessWidget {
  final List relatedApps;
  const RelatedApps({Key? key, required this.relatedApps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
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
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: relatedApps.length,
          itemBuilder: (BuildContext context, int index) {
            return SingleGridApp(
                rating: relatedApps[index]['rating'].toString(),
                seourl: relatedApps[index]['seourl'],
                name: relatedApps[index]['name'],
                icon: relatedApps[index]['icon'],
                starRating: relatedApps[index]['star_rating'].toString());
          },
        ),
      ],
    );
  }
}
