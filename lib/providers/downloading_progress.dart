import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadingProgress extends ChangeNotifier {
  int _progress = 0;
  DownloadTaskStatus _downloadTaskStatus = DownloadTaskStatus.undefined;
  String _id = "";
  String _appName = '';

  int get progress => _progress;

  DownloadTaskStatus get downloadTaskStatus => _downloadTaskStatus;

  String get id => _id;

  String get appName => _appName;

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

  void setDownloadingPSIN(int progress, DownloadTaskStatus downloadTaskStatus, String id, String appName) {
    _progress = progress;
    _downloadTaskStatus = downloadTaskStatus;
    _id = id;
    _appName = appName;
    notifyListeners();
  }
}
