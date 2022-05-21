import 'dart:io';
import 'package:apkdojo/common_methods/download_methods/get_app_list_in_directory.dart';
import 'package:apkdojo/common_methods/download_methods/filepath_to_filename.dart';

Future<bool> isOldVersionAlreadyAvaiable(String name) async {
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
