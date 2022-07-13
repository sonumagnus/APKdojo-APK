class Calculation {
  static int getNumberSequence({required int maxNumber, required int index}) {
    if (index < maxNumber) return index;
    int newNum = index % maxNumber;
    return newNum;
  }

  static String getDownloadPercentage({required String size, required int progress}) {
    String apkSize = size.replaceAll("..", "").replaceAll("MB", "");
    double appSize = double.parse(apkSize);
    double downloadedSize = (appSize * progress / 100);
    String roundedDownloadSize = downloadedSize.toStringAsFixed(2);
    return roundedDownloadSize;
  }
}
