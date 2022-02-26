import 'package:apkdojo/widgets/main_ui_widgets/single_grid_app.dart';
import 'package:flutter/material.dart';

class DownloadPageAppSugesion extends StatelessWidget {
  final List relatedAppList;

  const DownloadPageAppSugesion({
    Key? key,
    required this.relatedAppList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 10 / 15,
      ),
      itemCount: relatedAppList.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleGridApp(
            name: relatedAppList[index]['name'],
            icon: relatedAppList[index]['icon'],
            seourl: relatedAppList[index]['seourl'],
            starRating: relatedAppList[index]['star_rating'].toString(),
            rating: relatedAppList[index]['rating'].toString());
      },
    );
  }
}
