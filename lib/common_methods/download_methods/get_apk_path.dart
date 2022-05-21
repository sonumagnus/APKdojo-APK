import 'package:apkdojo/common_methods/download_methods/get_apk_directory.dart';

Future<String> getApkPath(String name, String version) async {
  String _apkFilesDirectory = await getApksDirectory();
  String _apkFilePath = _apkFilesDirectory + "/" + name + "_" + version.trimRight() + ".apk";
  return _apkFilePath;
}
