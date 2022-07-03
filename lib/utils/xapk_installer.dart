import 'dart:io';
import 'package:apkdojo/utils/app_methods.dart';
import 'package:archive/archive_io.dart';
import 'package:open_file/open_file.dart';
import 'package:package_archive_info/package_archive_info.dart';
import 'package:path_provider/path_provider.dart';

abstract class XapkInstaller {
  static install({required String apkPath}) async {
    late List<FileSystemEntity> allFiles, apkFiles;
    late PackageArchiveInfo appInfo;
    late String appPackageName;

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    String appName = apkPath.split("/").last.replaceAll(".xapk", "");
    String zipFilePath = tempDir.path + "/${appName}_zip";
    // this function convert xapk in zip file and moves in appname_zip dirctory
    _moveFile(File(apkPath), zipFilePath, appName);

    final bytes = File(zipFilePath + "/$appName" + ".zip").readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    // Extract the contents of the Zip archive to disk app cache.
    for (final file in archive) {
      final String filename = file.name;

      if (file.isFile) {
        final data = file.content as List<int>;
        File(tempDir.path + "/$appName" + "/$filename")
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory(tempPath).create(recursive: true);
      }
    }
    final Directory myDir = Directory(tempDir.path + "/$appName");

    allFiles = myDir.listSync(recursive: true, followLinks: true);

    apkFiles = allFiles.where((element) => element.path.endsWith('.apk')).toList();
    for (int x = 0; x < apkFiles.length; x++) {
      final String filePath = apkFiles[x].path;
      try {
        appInfo = await PackageArchiveInfo.fromPath(filePath);
        appPackageName = appInfo.packageName;
      } catch (e) {
        appInfo = PackageArchiveInfo(appName: "", packageName: "", version: "", buildNumber: "");
      }
      if (appInfo.appName.isNotEmpty && appPackageName == App.apkName(apkPath: filePath)) {
        try {
          // moving real app from extracting folder to APKdojo folder
          File(filePath).copySync(await App.getApksDirectory() + "/$appName.apk");

          // moving obb file to android/obb folder
          _moveObbToAndroidDir(allFiles, appPackageName);

          // showing popup to install app
          await OpenFile.open(filePath);

          // deleting .xapk file after moving real extracted app in the APKdojo folder and obb file into android folder
          File(await App.getApksDirectory() + "/$appName" + ".xapk").delete();
        } catch (e) {
          //error in installing
        }
      }
    }
    // clearing cache file after installing xapk
    Future.delayed(const Duration(seconds: 180), () {
      tempDir.deleteSync(recursive: true);
      tempDir.create();
    });
  }

  static _moveFile(File sourceFile, String newPath, String appname) async {
    if (!Directory(newPath).existsSync()) Directory(newPath).createSync();
    final String zipFilePath = "$newPath/" + appname + ".zip";

    try {
      return sourceFile.copySync(zipFilePath);
    } on FileSystemException {
      // if rename fails, copy the source file and then delete it
      await sourceFile.copy(zipFilePath);
      await sourceFile.delete();
    }
  }

  static _moveObbToAndroidDir(List<FileSystemEntity> allFiles, String appPackageName) async {
    for (int x = 0; x < allFiles.length; x++) {
      final fileExtension = allFiles[x].path.split("/").last.split(".").last;

      if (fileExtension == "obb") {
        String filepath = allFiles[x].path;
        String obbFileName = filepath.split("/").last.split(".").first;

        String obbDirPath = await App.internalStoragePath() + "/" + "Android" + "/" + "obb" + "/" + appPackageName;

        // creating the directory inside android/obb folder to place obb files
        if (!Directory(obbDirPath).existsSync()) Directory(obbDirPath).createSync();

        // rename path should also contains filename means whole path with filename and extension
        final String renamePath = obbDirPath + "/" + obbFileName + ".obb";

        try {
          // syncronus copying
          File(filepath).copySync(renamePath);
        } on FileSystemException {
          // in case of exception copying asyncronushly
          await File(filepath).copy(renamePath);
        }
      }
    }
  }
}
