import 'dart:io';
import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/utils/app_methods.dart';
import 'package:apkdojo/widgets/main_ui_widgets/basic_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class DownloadManager extends StatefulWidget {
  const DownloadManager({Key? key}) : super(key: key);

  @override
  State<DownloadManager> createState() => _DownloadManagerState();
}

class _DownloadManagerState extends State<DownloadManager> {
  late List<FileSystemEntity> _apkFiles;

  Future<void> getApplicationList() async {
    _apkFiles = await App.getListOfApplicationsFromDirectory();
    setState(() {});
  }

  Future<List<String>> getApkIcon(String apkPath) async {
    String apkIconURL = "";
    String apkSeoUrl = "";
    String apkDeveloper = "";
    String _appName = App.apkName(apkPath);

    if (_appName.contains(":")) {
      _appName = _appName.split(":").first;
    } else if (_appName.contains("&")) {
      _appName = _appName.split("&").first;
    } else if (_appName.contains("–")) {
      _appName = _appName.split("–").first;
    }

    Response _res = await Dio().get(
      "$apiDomain/search.php?q=${_appName.trim()}",
    );
    if (_res.data != []) {
      apkIconURL = _res.data.first!["icon"];
      apkSeoUrl = _res.data.first!['seourl'];
      apkDeveloper = _res.data.first!['developer'];
    } else {
      return [];
    }
    return [apkIconURL, apkSeoUrl, apkDeveloper];
  }

// delete a file
  Future<void> _deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        setState(() {
          getApplicationList();
        });
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  Future<void> _deleteConfirmationAlertBox(String file) async {
    var snackBar = SnackBar(content: Text("${App.apkName(file)} Deleted"));
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do You Really Want to Delete ${App.apkName(file)} ?'),
          actions: [
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                _deleteFile(File(file));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _apkFiles = [];
    getApplicationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar(title: "Downloads", context: context),
      body: _apkFiles.isEmpty
          ? "No Downloads".text.size(25).medium.gray400.makeCentered()
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _apkFiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          FutureBuilder<List>(
                            future: getApkIcon(_apkFiles[index].path),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      createRouteRightToLeft(
                                        targetRoute: Slug(
                                          seourl: snapshot.data![1],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        "${snapshot.data!.first}",
                                      ),
                                    ),
                                    title: "${App.apkName(_apkFiles[index].path)}".text.color(Theme.of(context).textTheme.titleMedium!.color).medium.make(),
                                    subtitle: "${snapshot.data![2]}".text.color(Theme.of(context).textTheme.titleSmall!.color).make(),
                                    trailing: popupMenuButtonBox(
                                      index,
                                      snapshot,
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return offlineDownloadManager(index);
                              }
                              return offlineDownloadManager(index);
                            },
                          ),
                          const Divider(height: 8).pOnly(left: 80, right: 40)
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  PopupMenuButton<MenuItem> popupMenuButtonBox(
    int index,
    AsyncSnapshot<List<dynamic>> snapshot,
  ) {
    return PopupMenuButton<MenuItem>(
      elevation: 1,
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        TextStyle _popupTitleStyles = TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.labelMedium!.color,
        );
        return [
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.install_mobile_sharp).pOnly(right: 9),
                Text("Install", style: _popupTitleStyles),
              ],
            ),
            onTap: () => OpenFile.open(_apkFiles[index].path),
          ),
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.delete_outline_rounded).pOnly(right: 9),
                Text("Delete", style: _popupTitleStyles),
              ],
            ),
            onTap: () {
              Future.delayed(const Duration(seconds: 0), () => _deleteConfirmationAlertBox(_apkFiles[index].path));
            },
          ),
          PopupMenuItem(
            onTap: () => Share.share('https://www.apkdojo.com/${snapshot.data![1]}'),
            child: Row(
              children: [
                const Icon(Icons.share_rounded).pOnly(right: 9),
                Text("Share", style: _popupTitleStyles),
              ],
            ),
          ),
        ];
      },
    );
  }

  ListTile offlineDownloadManager(int index) {
    return ListTile(
      leading: Image.asset("assets/images/lazy_images/lazy-image.jpg"),
      title: "${App.apkName(_apkFiles[index].path)}".text.gray800.medium.make(),
      trailing: PopupMenuButton<MenuItem>(
        elevation: 1,
        position: PopupMenuPosition.under,
        padding: EdgeInsets.zero,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: const Text("Install"),
              onTap: () => OpenFile.open(_apkFiles[index].path),
            ),
            PopupMenuItem(
              child: const Text("Delete"),
              onTap: () => Future.delayed(const Duration(seconds: 0), () => _deleteConfirmationAlertBox(_apkFiles[index].path)),
            ),
          ];
        },
      ),
    );
  }
}
