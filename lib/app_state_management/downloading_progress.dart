import 'package:flutter/material.dart';

class DownloadingProgress extends ChangeNotifier {
  int progress = 0;
  int counter = 5;

  void setProgress(int updatedProgress) {
    progress = updatedProgress;
    notifyListeners();
  }

  void setCounter(int newCounterValue) {
    counter = newCounterValue;
    notifyListeners();
  }
}
