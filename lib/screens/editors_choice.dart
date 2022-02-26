import 'package:apkdojo/widgets/loading_animation_widgets/category_app_listing_animation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_horizonatal_app_tile.dart';

class EditorsChoicePage extends StatefulWidget {
  const EditorsChoicePage({Key? key}) : super(key: key);

  @override
  _EditorsChoicePageState createState() => _EditorsChoicePageState();
}

class _EditorsChoicePageState extends State<EditorsChoicePage> {
  late Future<Map> editorsChoiceApps;

  Future<Map> getEditorsChoiceApps() async {
    var response = await Dio()
        .get('https://api.apkdojo.com/v-apps.php?type=featured_apps&lang=en');
    return response.data;
  }

  @override
  void initState() {
    editorsChoiceApps = getEditorsChoiceApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editor's Choice"),
      ),
      body: FutureBuilder<Map>(
        future: editorsChoiceApps,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!['featured_apps'].length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleHorizontalAppTile(
                    seourl: snapshot.data!['featured_apps'][index]['seourl'],
                    icon: snapshot.data!['featured_apps'][index]['icon'],
                    name: snapshot.data!['featured_apps'][index]['name'],
                  );
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CategoryAppListingAnimation(
            animatedTileCount: 9,
          );
        },
      ),
    );
  }
}
