import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/screens/downloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:apkdojo/app_state_management/downloading_progress.dart';

class SlugIconNameDownloadButton extends StatefulWidget {
  final String icon;
  final String name;
  final String developer;
  final String developerUrl;
  final String seourl;
  final String apkurl;
  const SlugIconNameDownloadButton({
    Key? key,
    required this.icon,
    required this.name,
    required this.developer,
    required this.developerUrl,
    required this.seourl,
    required this.apkurl,
  }) : super(key: key);

  @override
  State<SlugIconNameDownloadButton> createState() =>
      _SlugIconNameDownloadButtonState();
}

class _SlugIconNameDownloadButtonState
    extends State<SlugIconNameDownloadButton> {
  final downloadingProgress = DownloadingProgress();
  // int progress = 0;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // ignore: unused_local_variable
      String id = data[0];
      // ignore: unused_local_variable
      DownloadTaskStatus status = data[1];
      downloadingProgress.setProgress(data[2]);
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  void _download(String url, String name) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      Directory? externalDir = await getExternalStorageDirectory();

      String newPath = "";
      // print(externalDir!.path);
      List<String> paths = externalDir!.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
      newPath = newPath + "/APKdojo";
      externalDir = Directory(newPath);

      if (!await externalDir.exists()) {
        await externalDir.create(recursive: true);
      }

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: name,
        savedDir: externalDir.path + "/",
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: false,
      );
    } else {
      // ignore: avoid_print
      print('Permission Denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              widget.icon,
              width: 80,
              height: 80,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DevProfileAndApps(
                        devURL: widget.developerUrl,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Text(
                      "• ",
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                    Text(
                      widget.developer,
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // _download(widget.apkurl, "${widget.name}.apk");
                      _download(
                          "https://images.unsplash.com/photo-1647293566959-fcebc61c70f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Mnx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60",
                          "${widget.name}.jpg");

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Download(seourl: widget.seourl),
                      //   ),
                      // );
                    },
                    child: const Text("Download"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                  Text(downloadingProgress.progress.toString()),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green.shade100),
                      color: Colors.grey.shade100,
                    ),
                    child: const Icon(
                      Icons.share,
                      size: 18,
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
