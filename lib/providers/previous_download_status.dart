import 'package:flutter/material.dart';

class PreviousDownloadStatus extends ChangeNotifier {
  bool _appAlreadyDownload = false;
  String _appPath = "";
  bool _isOldVersionAvailable = false;

  bool get appAlreadyDownloaded => _appAlreadyDownload;
  String get appPath => _appPath;
  bool get isOldVersionAvailable => _isOldVersionAvailable;

  void setIsAppAlreadyDownloaded(bool status, {String apkPath = '', bool isOldVersionAvailable = false}) {
    _appAlreadyDownload = status;
    _appPath = apkPath;
    _isOldVersionAvailable = isOldVersionAvailable;
    notifyListeners();
  }
}
