import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/utils/app_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SlugStateManagments {
  static void isDownloadednInstalled(BuildContext context, {required String name, required String packageName, required String version}) async {
    bool isApkAlreadyDownloaded = await App.isApkFileAlreadyDownloaded(apkName: name, packageName: packageName, currentVersion: version);

    bool isOldVersionAvailable = await App.isOldVersionAlreadyAvaiable(packageName: packageName, currentVersion: version);

    context.read<SingleAPkState>().setIsAppAlreadyDownloaded(isApkAlreadyDownloaded, isOldVersionAvailable: isOldVersionAvailable);

    checkIfAppInstalled(context, packageName: packageName);
  }

  static void checkIfAppInstalled(BuildContext context, {required String packageName}) async {
    bool isApkInstalled = false;
    isApkInstalled = await App.isInstalled(packageName: packageName);
    context.read<SingleAPkState>().setIsAppInstalled(isAppInstalled: isApkInstalled);
  }
}
