import 'dart:async';

import 'package:flutter/material.dart';

class DownloadingProgress extends ChangeNotifier {
  int _progress = 0;
  String _appName = '';

  int get progress => _progress;
  String get appName => _appName;

  void setProgress(int updatedProgress) {
    _progress = updatedProgress;

    if (_progress == 100) {
      Timer(const Duration(seconds: 1), () {
        _progress = 0;
        notifyListeners();
        return;
      });
    }
    notifyListeners();
  }

  void setAppName(String _currentDownloadingAppName) {
    _appName = _currentDownloadingAppName;
    if (_progress == 100) {
      Timer(const Duration(seconds: 1), () {
        _appName = '';
        notifyListeners();
        return;
      });
      notifyListeners();
    }
  }
}
