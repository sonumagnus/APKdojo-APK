import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/providers/previous_download_status.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/utils/app_methods.dart';
import 'package:apkdojo/widgets/dio_error_message.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/slug_animation.dart';
import 'package:apkdojo/widgets/slug_component_widgets/apk_datail_expansion_panel.dart';
import 'package:apkdojo/widgets/slug_component_widgets/developer_apps.dart';
import 'package:apkdojo/widgets/slug_component_widgets/rating_size_version.dart';
import 'package:apkdojo/widgets/slug_component_widgets/related_apps.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_custom_card_shadow.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_description.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_screenshot.dart';
import 'package:apkdojo/widgets/slug_component_widgets/slug_top_icon_with_name.dart';
import 'package:apkdojo/widgets/slug_component_widgets/user_review_expansion_panel.dart';
import 'package:apkdojo/widgets/slug_component_widgets/whats_new_expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class Slug extends StatefulWidget {
  final String seourl;
  const Slug({Key? key, required this.seourl}) : super(key: key);

  @override
  State<Slug> createState() => _SlugState();
}

class _SlugState extends State<Slug> {
  late Future<Map> app;
  late ScrollController _controller;
  bool _showHeaderName = false;

  Future<Map> fetchApp() async {
    final String _api = '$apiDomain/app.php?id=${widget.seourl}&lang=en';
    Response response = await Dio().get(_api);
    return response.data;
  }

  _scrollListener() {
    if (_controller.offset >= 100 && !_controller.position.outOfRange) {
      if (_showHeaderName == true) return;
      setState(() => _showHeaderName = true);
    }
    if (_controller.offset <= 100 && !_controller.position.outOfRange) {
      if (_showHeaderName == false) return;
      setState(() => _showHeaderName = false);
    }
  }

  @override
  void initState() {
    setState(() {
      app = fetchApp();
    });
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<Map>(
        future: app,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  _showHeaderName ? snapshot.data!["name"] : "",
                  style: const TextStyle(color: Colors.black),
                ),
                elevation: 0,
                backgroundColor: Colors.white12,
                iconTheme: IconThemeData(
                  color: CustomColor.iconThemeColor,
                ),
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 85),
                    controller: _controller,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlugTopIconWithName(
                          icon: snapshot.data!['icon'],
                          developer: snapshot.data!['developer'],
                          developerUrl: snapshot.data!['developer_url'],
                          name: snapshot.data!['name'],
                          seourl: snapshot.data!['seourl'],
                          apkurl: snapshot.data!['apkurl'],
                          playStoreUrl: snapshot.data!['playstore'],
                          version: snapshot.data!['version'].toString(),
                        ),
                        RatingSizeVersionTable(
                          rating: snapshot.data!['rating'].toString(),
                          size: snapshot.data!['size'],
                          version: snapshot.data!['version'],
                          totalRating: snapshot.data!['total_ratings'].toString(),
                        ),
                        SlugDescription(
                          description: snapshot.data!['des'],
                        ),
                        SlugScreenshot(
                          screenshotCount: snapshot.data!['screenshots'].length,
                          screenshots: snapshot.data!['screenshots'],
                        ),
                        SlugCustomCardShadow(
                          child: Column(
                            children: [
                              UserReviewsExpansionPanel(appData: snapshot.data),
                              ApkDetailsExpansionPanel(appData: snapshot.data),
                              WhatsNewExpansionPanel(appData: snapshot.data),
                            ],
                          ),
                        ),
                        DeveloperApps(seourl: snapshot.data!['seourl']),
                        RelatedApps(relatedApps: snapshot.data!['related'])
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: snapshot.data!['apkurl'] == ""
                        ? const SizedBox()
                        : Column(
                            children: [
                              "Viewing: ${snapshot.data!['name']}".text.size(12).make().box.alignCenter.green200.width(context.mq.size.width).padding(Vx.mSymmetric(v: 6)).make(),
                              Container(
                                height: 55,
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: GridView(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 6 / 1.3,
                                    crossAxisSpacing: 8,
                                  ),
                                  children: [
                                    InkWell(
                                      onTap: () => Share.share(
                                        "https://www.apkdojo.com/${widget.seourl}",
                                      ),
                                      child: const BottomSheetButton(buttonName: "SHARE"),
                                    ).box.border(width: 1, color: Vx.gray200).withRounded(value: 4).make(),
                                    Consumer<PreviousDownloadStatus>(builder: (context, value, child) {
                                      return InkWell(
                                        onTap: () {
                                          if (value.appAlreadyDownloaded && !value.isOldVersionAvailable) {
                                            OpenFile.open(value.appPath);
                                          } else {
                                            App.download(snapshot.data!['apkurl'], "${snapshot.data!['name']}_${snapshot.data!['version']}");
                                            context.read<DownloadingProgress>().setAppName(snapshot.data!['name']);
                                          }
                                        },
                                        child: BottomSheetButton(
                                          buttonName: value.appAlreadyDownloaded && !value.isOldVersionAvailable
                                              ? "OPEN"
                                              : value.appAlreadyDownloaded && value.isOldVersionAvailable
                                                  ? "UPDATE"
                                                  : "DOWNLOAD",
                                          buttonBackgroundColor: Colors.green.shade400,
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const DioErrorMessage();
          }
          return const Center(
            child: SlugLoadingAnimation(),
          );
        },
      ),
    );
  }
}

class BottomSheetButton extends StatelessWidget {
  final String buttonName;
  final Color buttonBackgroundColor;
  const BottomSheetButton({
    Key? key,
    required this.buttonName,
    this.buttonBackgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      height: 35,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(buttonName == "SHARE" ? Icons.share : Icons.download, size: 16, color: buttonBackgroundColor == Colors.white ? Colors.green : Colors.white),
          buttonName.text.bold.letterSpacing(0.4).color(buttonBackgroundColor == Colors.white ? Colors.grey.shade700 : Colors.white).make().pOnly(left: 6),
        ],
      ),
    );
  }
}
