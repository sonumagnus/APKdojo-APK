fileName(String filePath) {
  final _splitedList = filePath.split("/");
  final _apkNameWithExtension = _splitedList[_splitedList.length - 1];
  final _apkNameWithoutExtension = _apkNameWithExtension.replaceAll(".apk", "");
  return _apkNameWithoutExtension;
}
