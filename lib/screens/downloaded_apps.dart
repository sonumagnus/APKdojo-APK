import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DownloadedApps extends StatefulWidget {
  const DownloadedApps({Key? key}) : super(key: key);

  @override
  State<DownloadedApps> createState() => _DownloadedAppsState();
}

class _DownloadedAppsState extends State<DownloadedApps> {
  late List<FileSystemEntity> _allFiles;
  late List<FileSystemEntity> _apkFiles;

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
    // ignore: avoid_print
    print(_apkFiles);
  }

  _fileName(String filePath) {
    final _splitedList = filePath.split("/");
    final _apkNameWithExtension = _splitedList[_splitedList.length - 1];
    final _apkNameWithoutExtension =
        _apkNameWithExtension.replaceAll(".apk", "");
    return _apkNameWithoutExtension;
  }

  @override
  void initState() {
    super.initState();
    _apkFiles = [];
    getDir();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _apkFiles.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                OpenFile.open(_apkFiles[index].path);
              },
              child: Text(
                _fileName(
                  _apkFiles[index].path,
                  // _apkFiles[index].path.replaceAll(".apk", ''),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
