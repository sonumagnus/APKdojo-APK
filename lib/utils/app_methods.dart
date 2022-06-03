import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class App {
  static fileName(String filePath) {
    final _splitedList = filePath.split("/");
    final _apkNameWithExtension = _splitedList.last;
    final _apkNameWithoutExtension = _apkNameWithExtension.replaceAll(".apk", "");
    return _apkNameWithoutExtension;
  }

  static apkName(String filePath) {
    final String _apkNameWithoutExtension = fileName(filePath);
    final List<String> _splitedListofNameAndVersion = _apkNameWithoutExtension.split("_");
    final String _realAppName = _splitedListofNameAndVersion.first;
    return _realAppName;
  }

  static createApplicationDirectory() async {
    Directory? externalDir;

    String newPath = await getApksDirectory();
    externalDir = Directory(newPath);

    if (!await externalDir.exists()) {
      await externalDir.create(recursive: true);
    }
  }

  // method for
  static Future<String> getApksDirectory() async {
    Directory? directory = await getExternalStorageDirectory();
    String _apkPath = "";

    List<String> path = directory!.path.split("/");
    for (int x = 1; x < path.length; x++) {
      String folder = path[x];
      if (folder != "Android") {
        _apkPath += "/" + folder;
      } else {
        break;
      }
    }

    String _apkListPath = _apkPath + "/APKdojo";
    return _apkListPath;
  }

  static Future<List<FileSystemEntity>> getListOfApplicationsFromDirectory() async {
    late List<FileSystemEntity> apkFiles;
    late List<FileSystemEntity> allFiles;

    Directory? directory;
    String _newPath = await getApksDirectory();

    directory = Directory(_newPath);

    final dir = directory.path;
    String apkDirectory = '$dir/';
    final myDir = Directory(apkDirectory);

    // creating application directory if isn't exist
    await createApplicationDirectory();

    allFiles = myDir.listSync(recursive: true, followLinks: true);

    apkFiles = allFiles.where((element) => element.path.endsWith('.apk')).toList();
    return apkFiles;
  }

  // function to access Single app path
  static Future<String> getApkPath(String name, String version) async {
    String _apkFilesDirectory = await getApksDirectory();
    String _apkFilePath = _apkFilesDirectory + "/" + name + "_" + version.trimRight() + ".apk";
    return _apkFilePath;
  }

// check if the app is already available in the application specific directory
  static Future<bool> isApkFileAlreadyDownloaded(String name, String version) async {
    bool _apkAlreadyDownloaded = false;

    String _apkFilePath = await getApkPath(name, version);

    if (File(_apkFilePath).existsSync()) {
      _apkAlreadyDownloaded = true;
    }

    return _apkAlreadyDownloaded;
  }

  static Future<bool> isOldVersionAlreadyAvaiable(String name) async {
    late List<FileSystemEntity> _apkFiles;
    bool oldVersionAvailable = false;

    _apkFiles = await getListOfApplicationsFromDirectory();

    for (int i = 0; i < _apkFiles.length; i++) {
      String _apkNameWithVersion = fileName(_apkFiles[i].path);
      bool _isContainsName = _apkNameWithVersion.contains(name);
      if (_isContainsName) {
        oldVersionAvailable = _isContainsName;
      }
    }
    return oldVersionAvailable;
  }

  static download(String url, String name) async {
    final status = await Permission.storage.request();
    final applicationSpecificFolderPath = await getApksDirectory();

    if (status.isGranted) {
      // creating application directory if isn't exist
      await createApplicationDirectory();

      // ignore: unused_local_variable
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: name.trimRight() + '.apk',
        savedDir: applicationSpecificFolderPath + "/",
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: false,
      );
    } else {
      // debugPrint('Permission Denied');
    }
  }
}
