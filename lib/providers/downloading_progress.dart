import 'dart:async';

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

    if (_progress >= 100) {
      Timer(
        const Duration(seconds: 1),
        () {
          _progress = 0;
          notifyListeners();
          return;
        },
      );
    }
    notifyListeners();
  }

  void setDownloadTaskStatus(DownloadTaskStatus currentDownloadTaskStatus) {
    _downloadTaskStatus = currentDownloadTaskStatus;
    if (currentDownloadTaskStatus == DownloadTaskStatus.complete) {
      _downloadTaskStatus = DownloadTaskStatus.undefined;
    }
    notifyListeners();
  }

  void setId(String newId) {
    _id = newId;
    if (progress >= 100) {
      _id = "";
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  void setAppName(String _currentDownloadingAppName) {
    if (_progress != 100) {
      _appName = _currentDownloadingAppName;
    } else {
      _appName = "";
      notifyListeners();
      return;
    }
    notifyListeners();
  }
}
