import 'dart:io';

import 'package:apkdojo/common_methods/download_methods/create_application_directory.dart';
import 'package:apkdojo/common_methods/download_methods/get_apk_directory.dart';

Future<List<FileSystemEntity>> getListOfApplicationsFromDirectory() async {
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
