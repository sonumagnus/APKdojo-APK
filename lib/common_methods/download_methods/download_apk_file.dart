import 'package:apkdojo/common_methods/download_methods/create_application_directory.dart';
import 'package:apkdojo/common_methods/download_methods/get_apk_directory.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

void download(String url, String name) async {
  final status = await Permission.storage.request();
  final applicationSpecificFolderPath = await getApksDirectory();

  if (status.isGranted) {
    // creating application directory if isn't exist
    await createApplicationDirectory();

    // ignore: unused_local_variable
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      fileName: name.trimRight() + '.apk',
      savedDir: applicationSpecificFolderPath + "/",
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: false,
    );
  } else {
    // debugPrint('Permission Denied');
  }
}
