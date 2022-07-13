import 'dart:io';
import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/utils/app_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  late List<FileSystemEntity> _apkFiles;

  Future<void> getApplicationList() async {
    _apkFiles = await App.getListOfApplicationsFromDirectory();
    setState(() {});
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
    var snackBar =
        SnackBar(content: Text("${App.apkName(apkPath: file)} Deleted"));
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(App.apkName(apkPath: file)),
          content: const Text(
            "Do You Really Want to Delete this application?",
          ),
          contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
          actions: [
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('DELETE'),
              onPressed: () {
                _deleteFile(File(file));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    return _apkFiles.isEmpty
        ? "No Downloads".text.size(25).medium.gray400.makeCentered()
        : ListView.builder(
            itemCount: _apkFiles.length,
            itemBuilder: (_, index) {
              var _app = _apkFiles[index];
              return Column(
                children: [
                  FutureBuilder<Map>(
                    future: App.getApkPathToApkDetailsFromDB(
                      apkPath: _app.path,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListTile(
                          leading: Image(
                            image: CachedNetworkImageProvider(
                              snapshot.data!['icon'].toString(),
                            ),
                            fit: BoxFit.fill,
                          )
                              .box
                              .square(50)
                              .clip(Clip.hardEdge)
                              .color(Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .color!)
                              .withRounded(value: 12)
                              .make(),
                          title: "${App.apkName(apkPath: _app.path)}"
                              .text
                              .color(Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color)
                              .medium
                              .make(),
                          subtitle: " ${snapshot.data!['developer']}"
                              .text
                              .color(Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color)
                              .make(),
                          trailing: popupMenuButtonBox(
                            index,
                            snapshot,
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Slug(
                                seourl: snapshot.data!['seourl'],
                              ),
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
          );
  }

  PopupMenuButton<MenuItem> popupMenuButtonBox(
    int index,
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot,
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
              Future.delayed(const Duration(seconds: 0),
                  () => _deleteConfirmationAlertBox(_apkFiles[index].path));
            },
          ),
          PopupMenuItem(
            onTap: () {
              Share.share('$siteDomain/${snapshot.data!['seourl']}');
            },
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
    TextTheme _textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Image.asset(
        "assets/images/lazy_images/lazy-image.jpg",
        fit: BoxFit.fill,
      )
          .box
          .square(50)
          .clip(Clip.hardEdge)
          .white
          .border(color: Vx.gray300)
          .withRounded(value: 12)
          .make(),
      title: "${App.apkName(apkPath: _apkFiles[index].path)}"
          .text
          .color(_textTheme.titleMedium!.color)
          .medium
          .make(),
      trailing: PopupMenuButton<MenuItem>(
        elevation: 1,
        padding: EdgeInsets.zero,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: "Install".text.color(_textTheme.titleMedium!.color).make(),
              onTap: () => OpenFile.open(_apkFiles[index].path),
            ),
            PopupMenuItem(
              child: "Delete".text.color(_textTheme.titleMedium!.color).make(),
              onTap: () => Future.delayed(
                const Duration(seconds: 0),
                () => _deleteConfirmationAlertBox(_apkFiles[index].path),
              ),
            ),
          ];
        },
      ),
    );
  }
}
