import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedApps extends StatefulWidget {
  const DownloadedApps({Key? key}) : super(key: key);

  @override
  State<DownloadedApps> createState() => _DownloadedAppsState();
}

class _DownloadedAppsState extends State<DownloadedApps> {
  late List<FileSystemEntity> _folders;
  Future<void> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String apkDirectory = '$dir/';
    final myDir = Directory(apkDirectory);
    setState(() {
      _folders = myDir.listSync(recursive: true, followLinks: true);
    });
    // ignore: avoid_print
    print(_folders);
  }

  @override
  void initState() {
    super.initState();
    _folders = [];
    getDir();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _folders.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(_folders[index].toString());
      },
    );
  }
}
