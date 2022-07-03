import 'package:apkdojo/widgets/category_list.dart';
import 'package:apkdojo/widgets/download_manager_widgets/device_installed_apps.dart';
import 'package:apkdojo/widgets/main_ui_widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:velocity_x/velocity_x.dart';

class DownloadManager extends HookWidget {
  const DownloadManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TabController tabController = useTabController(initialLength: 2);
    final _textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: basicAppBar(title: "Download Manager", context: context),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                color: Colors.transparent,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 42,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).primaryColor),
                      BoxShadow(
                        color: _textTheme.displayMedium!.color!,
                        spreadRadius: -1.0,
                        blurRadius: 1.0,
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                  ),
                  child: TabBar(
                    controller: tabController,
                    unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
                    labelColor: Theme.of(context).tabBarTheme.labelColor,
                    padding: const EdgeInsets.all(4.0),
                    indicator: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    tabs: const [
                      Tab(text: "DOWNLOADS"),
                      Tab(text: "INSTALLED"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: context.mq.size.width,
                height: context.mq.size.height - kToolbarHeight - 20,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    // Downloads(),
                    CategoryList(type: "apps", cateListCount: "15"),
                    DeviceInstalledApps(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
