import 'dart:io';
import 'package:apkdojo/common_methods/download_methods/apkpath_to_apkname.dart';
import 'package:apkdojo/common_methods/download_methods/get_app_list_in_directory.dart';
import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DownloadManager extends StatefulWidget {
  const DownloadManager({Key? key}) : super(key: key);

  @override
  State<DownloadManager> createState() => _DownloadManagerState();
}

class _DownloadManagerState extends State<DownloadManager> {
  late List<FileSystemEntity> _apkFiles;

  Future<void> getApplicationList() async {
    _apkFiles = await getListOfApplicationsFromDirectory();
    setState(() {});
  }

  Future<List<String>> getApkIcon(String apkPath) async {
    String apkIconURL = "";
    String apkSeoUrl = "";
    String apkDeveloper = "";
    String _appName = apkName(apkPath);

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
          getApplicationList();
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
          title: Text('Do You Really Want to Delete ${apkName(file)} ?'),
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
    getApplicationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        "${snapshot.data![0]}",
                                      ),
                                    ),
                                    title: Text(
                                      apkName(
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
                                      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                      child: GestureDetector(
                                        onTap: () => _deleteConfirmationAlertBox(_apkFiles[index].path),
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
        apkName(
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
