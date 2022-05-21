import 'package:apkdojo/common_methods/download_methods/filepath_to_filename.dart';

apkName(String filePath) {
  final String _apkNameWithoutExtension = fileName(filePath);
  final List<String> _splitedListofNameAndVersion = _apkNameWithoutExtension.split("_");
  final String _realAppName = _splitedListofNameAndVersion[0];
  return _realAppName;
}
