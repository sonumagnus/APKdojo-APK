import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> getApksDirectory() async {
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
