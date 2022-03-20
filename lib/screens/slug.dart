import 'package:apkdojo/main.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/slug_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/search_icon_widget.dart';
import 'package:apkdojo/widgets/slug_component_widgets/apk_details_expansion_panel.dart';
import 'package:apkdojo/widgets/slug_component_widgets/developer_apps.dart';
import 'package:apkdojo/widgets/slug_component_widgets/rating_size_version.dart';
import 'package:apkdojo/widgets/slug_component_widgets/related_apps.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_description.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_icon_name_download_button.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_screenshot.dart';
import 'package:apkdojo/widgets/slug_component_widgets/user_reviews_expansion_panel.dart';
import 'package:apkdojo/widgets/slug_component_widgets/whatsnew_expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Slug extends StatefulWidget {
  final String seourl;
  const Slug({Key? key, required this.seourl}) : super(key: key);

  @override
  State<Slug> createState() => _SlugState();
}

class _SlugState extends State<Slug> {
  late Future<Map> app;
  final List<bool> _isOpen = [true, false, false, false];

  Future<Map> fetchApp() async {
    var response = await Dio()
        .get('https://api.apkdojo.com/app.php?id=${widget.seourl}&lang=en');
    return response.data;
  }

  @override
  void initState() {
    setState(() {
      app = fetchApp();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          widget.seourl,
          style: TextStyle(color: appBarTitleColor),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: iconThemeColor),
        actions: const [SearchIconWidget()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<Map>(
          future: app,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  SlugIconNameDownloadButton(
                    icon: snapshot.data!['icon'],
                    developer: snapshot.data!['developer'],
                    developerUrl: snapshot.data!['developer_url'],
                    name: snapshot.data!['name'],
                    seourl: snapshot.data!['seourl'],
                    apkurl: snapshot.data!['apkurl'],
                  ),
                  RatingSizeVersionTable(
                    rating: snapshot.data!['rating'].toString(),
                    size: snapshot.data!['size'],
                    version: snapshot.data!['version'],
                  ),
                  SlugDescription(
                    description: snapshot.data!['des'],
                  ),
                  SlugScreenshot(
                      screenshotCount: snapshot.data!['screenshots'].length,
                      screenshots: snapshot.data!['screenshots']),
                  Container(
                    color: null,
                    child: ExpansionPanelList(
                      children: [
                        userReviewsExpansionPanel(snapshot, _isOpen),
                        apkDetailsExpansionPanel(snapshot, _isOpen),
                        whatsNewExpansionPanel(snapshot, _isOpen),
                      ],
                      expansionCallback: (i, isOpen) => setState(() {
                        _isOpen[i] = !isOpen;
                      }),
                    ),
                  ),
                  DeveloperApps(seourl: snapshot.data!['seourl']),
                  RelatedApps(relatedApps: snapshot.data!['related'])
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: SlugLoadingAnimation(),
            );
          },
        ),
      ),
    );
  }
}
