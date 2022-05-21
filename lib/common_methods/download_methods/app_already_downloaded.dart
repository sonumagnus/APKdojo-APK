import 'dart:io';
import 'package:apkdojo/common_methods/download_methods/get_apk_path.dart';

Future<bool> isApkFileAlreadyDownloaded(String name, String version) async {
  bool _apkAlreadyDownloaded = false;

  String _apkFilePath = await getApkPath(name, version);

  if (File(_apkFilePath).existsSync()) {
    _apkAlreadyDownloaded = true;
  }

  return _apkAlreadyDownloaded;
}
