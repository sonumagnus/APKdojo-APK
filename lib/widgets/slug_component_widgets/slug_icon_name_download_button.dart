import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:apkdojo/page_route_animation/bottom_to_top.dart';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/widgets/slug_component_widgets/share_model_fixed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
  final ReceivePort _port = ReceivePort();
  int progress = 0;

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
      progress = data[2];
      context.read<DownloadingProgress>().setProgress(data[2]);
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

      // download file name sequence generator logic

      final String _appName = widget.name;

      if (File(externalDir.path + "/" + name + ".jpg").existsSync()) {
        for (int i = 1; i < 100; i++) {
          name = _appName + "(" + "$i" + ")";
          if (!File(externalDir.path + "/" + name + ".jpg").existsSync()) {
            break;
          }
        }
      }

      // download file name sequence logic ends here

      // ignore: unused_local_variable
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: name + '.jpg',
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
                onDoubleTap: null,
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
                    Expanded(
                      child: Text(
                        widget.developer,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: GestureDetector(
                      onTap: () {
                        // _download(widget.apkurl, "${widget.name}.apk");
                        _download(
                            "https://images.unsplash.com/photo-1647937627312-e4f6589db6fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2OHx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60",
                            widget.name);

                        // context
                        //     .read<DownloadingProgress>()
                        //     .setAppName(widget.name);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 100,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 8.0,
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              child: LinearProgressIndicator(
                                value: double.parse("$progress") / 100,
                                backgroundColor: Colors.green,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                            ),
                          ),
                          Align(
                            child: Text(
                              progress == 0
                                  ? "Download"
                                  : progress < 100 && progress > 0
                                      ? "Downloading"
                                      : progress == 100
                                          ? "Downloaded"
                                          : "Download",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green.shade100),
                      color: Colors.grey.shade100,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          createRouteBottomToTop(
                            targetRoute: const ShareModelFixed(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.share,
                        size: 18,
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
