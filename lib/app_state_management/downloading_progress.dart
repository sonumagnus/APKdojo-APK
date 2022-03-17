import 'package:flutter/material.dart';

class DownloadingProgress extends ChangeNotifier {
  int _progress = 0;

  int get progress => _progress;

  void setProgress(int updatedProgress) {
    _progress = updatedProgress;
    notifyListeners();
  }
}
