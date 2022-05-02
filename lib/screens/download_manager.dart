import 'dart:io';
import 'package:apkdojo/common_methods/filepath_to_filename.dart';
import 'package:apkdojo/page_route_animation/right_to_left.dart';
// import 'package:apkdojo/providers/downloading_progress.dart';
// import 'package:apkdojo/screens/custom_download_progress_bar.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/widgets/main_ui_widgets/custom_appbar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';

class DownloadManager extends StatefulWidget {
  const DownloadManager({Key? key}) : super(key: key);

  @override
  State<DownloadManager> createState() => _DownloadManagerState();
}

class _DownloadManagerState extends State<DownloadManager> {
  late List<FileSystemEntity> _allFiles;
  late List<FileSystemEntity> _apkFiles;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Future<void> getDir() async {
    Directory? directory = await getExternalStorageDirectory();
    String _newPath = "";

    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        _newPath += "/" + folder;
      } else {
        break;
      }
    }
    _newPath = _newPath + "/APKdojo";
    directory = Directory(_newPath);

    final dir = directory.path;
    String apkDirectory = '$dir/';
    final myDir = Directory(apkDirectory);
    _allFiles = myDir.listSync(recursive: true, followLinks: true);
    setState(() {
      _apkFiles =
          _allFiles.where((element) => element.path.endsWith('.apk')).toList();
    });
  }

  _apkName(String filePath) {
    final String _apkNameWithoutExtension = fileName(filePath);
    final List<String> _splitedListofNameAndVersion =
        _apkNameWithoutExtension.split("_");
    final String _realAppName = _splitedListofNameAndVersion[0];
    return _realAppName;
  }

  Future<List<String>> getApkIcon(String apkPath) async {
    String apkIconURL = "";
    String apkSeoUrl = "";
    String apkDeveloper = "";
    String _appName = _apkName(apkPath);

    if (_appName.contains(":")) {
      _appName = _appName.split(":")[0];
    } else if (_appName.contains("&")) {
      _appName = _appName.split("&")[0];
    } else if (_appName.contains("–")) {
      _appName = _appName.split("–")[0];
    }

    Response _res = await Dio().get(
      "https://api.apkdojo.com/search.php?q=${_appName.trimLeft().trimRight()}",
    );
    if (_res.data != []) {
      apkIconURL = _res.data![0]!["icon"];
      apkSeoUrl = _res.data![0]!['seourl'];
      apkDeveloper = _res.data![0]!['developer'];
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
          getDir();
        });
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  Future<void> _deleteConfirmationAlertBox(String file) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do You Really Want to Delete ${_apkName(file)} ?'),
          actions: [
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                _deleteFile(File(file));
                Navigator.of(context).pop();
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
    getDir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(AppBar().preferredSize.height, context, _scaffoldKey),
      drawer: const MyDrawer(),
      body: _apkFiles.isEmpty
          ? Center(
              child: Text(
                "No Downloads",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
              ),
            )
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: Image.network(
                                        "${snapshot.data![0]}",
                                      ),
                                    ),
                                    title: Text(
                                      _apkName(
                                        _apkFiles[index].path,
                                      ),
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![2],
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 8, bottom: 8),
                                      child: GestureDetector(
                                        onTap: () =>
                                            _deleteConfirmationAlertBox(
                                                _apkFiles[index].path),
                                        child: Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.grey.shade700,
                                          size: 28,
                                        ),
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
                          const Padding(
                            padding: EdgeInsets.only(left: 80),
                            child: Divider(height: 8),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  ListTile offlineDownloadManager(int index) {
    return ListTile(
      leading: Image.asset(
        "assets/images/lazy_images/lazy-image.jpg",
      ),
      title: Text(
        _apkName(
          _apkFiles[index].path,
        ),
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: GestureDetector(
        onTap: () => _deleteConfirmationAlertBox(_apkFiles[index].path),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
