import 'dart:io';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:device_apps/device_apps.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:package_archive_info/package_archive_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class App {
  // get apk name from path (includes name_version)
  static fileName({required String filePath}) {
    final _splitedList = filePath.split("/");
    final _apkNameWithExtension = _splitedList.last;
    final _apkNameWithoutExtension =
        _apkNameWithExtension.replaceAll(".apk", "");
    return _apkNameWithoutExtension;
  }

  // Get apk name (without _version) from apk path
  static apkName({required String apkPath}) {
    final String _apkNameWithoutExtension = fileName(filePath: apkPath);
    final List<String> _splitedListofNameAndVersion =
        _apkNameWithoutExtension.split("_");
    final String _realAppName = _splitedListofNameAndVersion.first;
    return _realAppName;
  }

  // Create Application Directory if it doesn't exist
  static createApplicationDirectory() async {
    Directory? externalDir;

    String newPath = await getApksDirectory();
    externalDir = Directory(newPath);

    if (!await externalDir.exists()) {
      await externalDir.create(recursive: true);
    }
  }

  // get starting path for local storage path
  static Future<String> internalStoragePath() async {
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
    return _apkPath;
  }

  // method for path of application specific directory
  static Future<String> getApksDirectory() async {
    String _apkListPath = await internalStoragePath() + "/APKdojo";
    return _apkListPath;
  }

  // get list of all the .APK files those are located in application specific directory
  static Future<List<FileSystemEntity>>
      getListOfApplicationsFromDirectory() async {
    late List<FileSystemEntity> allFiles, apkFiles;
    String _newPath;
    Directory? directory;

    // Creating Application Directory if it doesn't exist Becausee to get list of all the
    //.APK files we need to create application specific directory must to avoid "no such directory error"
    await createApplicationDirectory();
    _newPath = await getApksDirectory();

    directory = Directory(_newPath);

    final dir = directory.path;
    String apkDirectory = '$dir/';
    final myDir = Directory(apkDirectory);

    allFiles = myDir.listSync(recursive: true, followLinks: true);

    apkFiles =
        allFiles.where((element) => element.path.endsWith('.apk')).toList();

    return apkFiles;
  }

  // Read the version of any app located in application specific directory
  static Future<String> getAppVersion({required String apkPath}) async {
    String _apkVersion;
    try {
      PackageArchiveInfo info = await PackageArchiveInfo.fromPath(apkPath);
      _apkVersion = info.version;
    } on PlatformException {
      _apkVersion = "0.0";
    } catch (e) {
      _apkVersion = "0.0";
    }
    return _apkVersion;
  }

  static Future<Map> getApkPathToApkDetailsFromDB(
      {required String apkPath}) async {
    Map data = {};
    try {
      PackageArchiveInfo info = await PackageArchiveInfo.fromPath(apkPath);
      String api = "https://appidmongo.herokuapp.com/${info.packageName}";
      Response res = await Dio().get(api);
      data = res.data;
    } catch (e) {
      return data;
    }
    return data;
  }

  // function to access Single app path
  static Future<String> getApkPath({required String apkName}) async {
    String _apkFilesDirectory = await getApksDirectory();
    String _apkFilePath = _apkFilesDirectory + "/" + apkName + ".apk";
    return _apkFilePath;
  }

  // check if the app is already available in the application specific directory
  static Future<bool> isApkFileAlreadyDownloaded(
      {required String apkName,
      required String packageName,
      required String currentVersion}) async {
    late List<FileSystemEntity> _apkFiles;
    bool apkAlreadyDownloaded = false;

    _apkFiles = await getListOfApplicationsFromDirectory();

    for (int i = 0; i < _apkFiles.length; i++) {
      try {
        PackageArchiveInfo _appInfo = await PackageArchiveInfo.fromPath(
          _apkFiles[i].path,
        );
        if (packageName == _appInfo.packageName) {
          if (_appInfo.version == currentVersion) {
            apkAlreadyDownloaded = true;
          } else {
            apkAlreadyDownloaded = false;
          }
          break;
        }
      } catch (e) {
        // return oldVersionAvailable;
      }
    }
    return apkAlreadyDownloaded;
  }

  static Future<bool> isInstalled({required String packageName}) async {
    bool isApkInstalled;
    try {
      isApkInstalled = await DeviceApps.isAppInstalled(packageName);
    } catch (e) {
      isApkInstalled = false;
    }
    return isApkInstalled;
  }

  // Check if the app's older version is already available in the directory
  static Future<bool> isOldVersionAlreadyAvaiable(
      {required String packageName, required String currentVersion}) async {
    late List<FileSystemEntity> _apkFiles;
    bool oldVersionAvailable = false;

    _apkFiles = await getListOfApplicationsFromDirectory();

    for (int i = 0; i < _apkFiles.length; i++) {
      try {
        PackageArchiveInfo _appInfo = await PackageArchiveInfo.fromPath(
          _apkFiles[i].path,
        );
        if (packageName == _appInfo.packageName) {
          if (_appInfo.version == currentVersion) {
            oldVersionAvailable = false;
          } else {
            oldVersionAvailable = true;
          }
          break;
        }
      } catch (e) {
        // return oldVersionAvailable;
      }
    }
    return oldVersionAvailable;
  }

  // Download method
  static download({required String url, required String name}) async {
    // extraction extesnion from the url
    List<String> splitedUrl = url.split(".");
    String apkExtension = splitedUrl.last;
    final status = await Permission.storage.request();
    final applicationSpecificFolderPath = await getApksDirectory();

    if (status.isGranted) {
      // creating application directory if isn't exist
      await createApplicationDirectory();

      // ignore: unused_local_variable
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: name.trim() + "." + apkExtension,
        savedDir: applicationSpecificFolderPath + "/",
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: false,
      );
    } else {
      // debugPrint('Permission Denied');
    }
  }

  static downloadButtonGesture(
      {required SingleAPkState globalState,
      required String apkName,
      required apkUrl,
      required String packageName}) async {
    bool downloadingRunning =
        globalState.downloadTaskStatus == DownloadTaskStatus.running;
    if (globalState.isApkInstalled && !downloadingRunning) {
      DeviceApps.openApp(packageName);
    } else if (globalState.appAlreadyDownloaded && !downloadingRunning) {
      OpenFile.open(await getApkPath(apkName: apkName));
    } else if (!downloadingRunning &&
        globalState.downloadTaskStatus == DownloadTaskStatus.undefined) {
      download(name: apkName, url: apkUrl);
    }
  }
}
