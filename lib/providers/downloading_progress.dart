import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class SingleAPkState extends ChangeNotifier {
  int _progress = 0;
  DownloadTaskStatus _downloadTaskStatus = DownloadTaskStatus.undefined;
  String _id = "";
  String _appName = '';

  bool _appAlreadyDownload = false;
  String _appPath = "";
  bool _isOldVersionAvailable = false;
  bool _isApkIntalled = false;

  int get progress => _progress;
  DownloadTaskStatus get downloadTaskStatus => _downloadTaskStatus;
  String get id => _id;
  String get appName => _appName;

  bool get appAlreadyDownloaded => _appAlreadyDownload;
  String get appPath => _appPath;
  bool get isOldVersionAvailable => _isOldVersionAvailable;
  bool get isApkInstalled => _isApkIntalled;

  void setProgress(int updatedProgress) {
    _progress = updatedProgress;
    notifyListeners();
  }

  void setDownloadTaskStatus(DownloadTaskStatus currentDownloadTaskStatus) {
    _downloadTaskStatus = currentDownloadTaskStatus;
    notifyListeners();
  }

  void setId(String newId) {
    _id = newId;
    notifyListeners();
  }

  void setAppName(String _currentDownloadingAppName) {
    _appName = _currentDownloadingAppName;
    notifyListeners();
  }

  void setDownloadingPSIN({required int progress, required DownloadTaskStatus downloadTaskStatus, required String id, required String appName}) {
    _progress = progress;
    _downloadTaskStatus = downloadTaskStatus;
    _id = id;
    _appName = appName;
    notifyListeners();
  }

  void setIsAppAlreadyDownloaded(bool status, {String apkPath = '', bool isOldVersionAvailable = false}) {
    _appAlreadyDownload = status;
    _appPath = apkPath;
    _isOldVersionAvailable = isOldVersionAvailable;
    notifyListeners();
  }

  void setIsAppInstalled({required bool isAppInstalled}) {
    _isApkIntalled = isAppInstalled;
    notifyListeners();
  }
}
