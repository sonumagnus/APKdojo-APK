import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class SingleAPkState extends ChangeNotifier {
  int _progress = 0;
  DownloadTaskStatus _downloadTaskStatus = DownloadTaskStatus.undefined;
  String _id = "";
  String _downloadingAppName = '';

  bool _appAlreadyDownload = false;
  bool _isOldVersionAvailable = false;
  bool _isApkIntalled = false;

  int get progress => _progress;
  DownloadTaskStatus get downloadTaskStatus => _downloadTaskStatus;
  String get id => _id;
  String get downloadingAppName => _downloadingAppName;

  bool get appAlreadyDownloaded => _appAlreadyDownload;
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
    _downloadingAppName = _currentDownloadingAppName;
    notifyListeners();
  }

  void setDownloadingPSIN({required int progress, required DownloadTaskStatus downloadTaskStatus, required String id, required String downloadingApkName}) {
    _progress = progress;
    _downloadTaskStatus = downloadTaskStatus;
    _id = id;
    _downloadingAppName = downloadingApkName;
    notifyListeners();
  }

  void isApkDonwloationDone({required bool isDonwloadedNow}) {
    _appAlreadyDownload = isDonwloadedNow;
  }

  void setIsAppAlreadyDownloaded(bool status, {bool isOldVersionAvailable = false}) {
    _appAlreadyDownload = status;
    _isOldVersionAvailable = isOldVersionAvailable;
    notifyListeners();
  }

  void setIsAppInstalled({required bool isAppInstalled}) {
    _isApkIntalled = isAppInstalled;
    notifyListeners();
  }
}
