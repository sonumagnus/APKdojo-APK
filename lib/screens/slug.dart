import 'dart:async';
import 'package:apkdojo/animation/show_up.dart';
import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/screens/search_screen.dart';
import 'package:apkdojo/utils/app_methods.dart';
import 'package:apkdojo/utils/calculation.dart';
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
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
  bool _showBottomDownloadButton = false;

  Future<Map> fetchApp() async {
    final String _api = '$apiDomain/app.php?id=${widget.seourl}&lang=en';
    Response response = await Dio().get(_api);
    return response.data;
  }

  _scrollListener() {
    final double scrollPosition = _controller.offset;
    final bool cpoor = _controller.position.outOfRange;

    if (scrollPosition > 120 && !cpoor) {
      if (_showBottomDownloadButton == true) return;
      setState(() => _showBottomDownloadButton = true);
    }

    if (scrollPosition <= 50 && !cpoor) {
      if (_showHeaderName == false) return;
      setState(() => _showHeaderName = false);
    }

    if (scrollPosition > 50 && scrollPosition <= 120 && !cpoor) {
      if (_showHeaderName == false) {
        setState(() => _showHeaderName = true);
      }
      if (_showBottomDownloadButton == true) {
        setState(() => _showBottomDownloadButton = false);
      }
      return;
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
    return FutureBuilder<Map>(
      future: app,
      builder: (context, snapshot) {
        final app = snapshot.data;
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: ShowUpAnimation(
                activate: _showHeaderName,
                child: Text(
                  snapshot.data!["name"],
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
              ),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: Theme.of(context).iconTheme,
              actions: [
                IconButton(
                  onPressed: () => showSearch(
                    context: context,
                    delegate: SearchScreen(),
                  ),
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () => Share.share(
                    "$siteDomain/${app!['seourl']}",
                  ),
                  icon: const Icon(Icons.share, size: 21),
                ),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: "${app!['apkurl']}".isEmpty ? 0 : 55,
                  ),
                  controller: _controller,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlugTopIconWithName(
                        icon: app['icon'],
                        developer: app['developer'],
                        developerUrl: app['developer_url'],
                        name: app['name'],
                        seourl: app['seourl'],
                        apkurl: app['apkurl'],
                        playStoreUrl: app['playstore'],
                        version: app['version'].toString(),
                        packageName: app['app_package'],
                        size: app['size'],
                      ),
                      RatingSizeVersionTable(
                        rating: app['rating'].toString(),
                        size: app['size'],
                        version: app['version'],
                        totalRating: app['total_ratings'].toString(),
                      ),
                      SlugScreenshot(screenshots: app['screenshots']),
                      SlugDescription(description: app['des']),
                      SlugCustomCardShadow(
                        hideUpshadow: true,
                        child: Column(
                          children: [
                            UserReviewsExpansionPanel(appData: app),
                            ApkDetailsExpansionPanel(appData: app),
                            WhatsNewExpansionPanel(appData: app),
                          ],
                        ),
                      ),
                      DeveloperApps(seourl: app['seourl']),
                      RelatedApps(relatedApps: app['related'])
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: _showBottomDownloadButton ? 0 : -58,
                  left: 0,
                  child: "${app['apkurl']}".isEmpty
                      ? const SizedBox()
                      : SlugBottomDownloadButtonSheet(
                          name: app['name'],
                          apkurl: app['apkurl'],
                          seourl: app['seourl'],
                          version: app['version'],
                          packageName: app['app_package'],
                          size: app['size'],
                        ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Material(child: DioErrorMessage());
        }
        return const Center(child: SlugLoadingAnimation());
      },
    );
  }
}

class SlugBottomDownloadButtonSheet extends StatelessWidget {
  final String name, apkurl, seourl, version, packageName, size;

  const SlugBottomDownloadButtonSheet({
    Key? key,
    required this.name,
    required this.apkurl,
    required this.seourl,
    required this.version,
    required this.packageName,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _buttonStyle = TextStyle(
      color: Colors.grey.shade200,
      fontWeight: FontWeight.w600,
    );
    return Consumer<SingleAPkState>(
      builder: (context, state, child) {
        bool downloadingRunning =
            state.downloadTaskStatus == DownloadTaskStatus.running;
        bool startCondition =
            downloadingRunning && name == state.downloadingAppName;
        return GestureDetector(
          onTap: () => App.downloadButtonGesture(
              globalState: state,
              apkName: name,
              apkUrl: apkurl,
              packageName: packageName),
          child: Stack(
            alignment:
                downloadingRunning ? Alignment.centerLeft : Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      offset: const Offset(0.0, -2.0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                height: 55,
                width: context.mq.size.width,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.green.shade500,
                  color: Colors.green.shade700,
                  value: state.progress / 100,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: context.mq.size.width,
                child: startCondition
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("DOWNLOADING...", style: _buttonStyle),
                              Text(
                                Calculation.getDownloadPercentage(
                                        progress: state.progress, size: size) +
                                    "MB" +
                                    "/$size",
                                style: _buttonStyle,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () =>
                                FlutterDownloader.cancel(taskId: state.id),
                            icon: Icon(
                              Icons.close_rounded,
                              color: Colors.grey.shade200,
                            ),
                          )
                        ],
                      )
                    : state.isApkInstalled
                        ? SizedBox(
                            width: context.mq.size.width,
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () =>
                                        DeviceApps.uninstallApp(packageName),
                                    child:
                                        Text("UNINSTALL", style: _buttonStyle),
                                  ),
                                ),
                                const VerticalDivider(color: Colors.white),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () =>
                                        DeviceApps.openApp(packageName),
                                    child: Text("OPEN", style: _buttonStyle),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : state.appAlreadyDownloaded && !downloadingRunning
                            ? Align(
                                alignment: Alignment.center,
                                child: Text("INSTALL", style: _buttonStyle),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Text(
                                    state.isOldVersionAvailable &&
                                            state.downloadTaskStatus !=
                                                DownloadTaskStatus.running
                                        ? "UPDATE"
                                        : "INSTALL",
                                    style: _buttonStyle),
                              ),
              ),
            ],
          ),
        );
      },
    );
  }
}
