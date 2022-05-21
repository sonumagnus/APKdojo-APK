import 'dart:io';
import 'package:apkdojo/common_methods/download_methods/get_apk_directory.dart';

createApplicationDirectory() async {
  Directory? externalDir;

  String newPath = await getApksDirectory();
  externalDir = Directory(newPath);

  if (!await externalDir.exists()) {
    await externalDir.create(recursive: true);
  }
}
