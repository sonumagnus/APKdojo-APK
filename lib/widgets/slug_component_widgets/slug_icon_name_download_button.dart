import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:apkdojo/page_route_animation/bottom_to_top.dart';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/widgets/slug_component_widgets/share_model_fixed.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  int progress = 0;
  String id = '';
  late DownloadTaskStatus status = DownloadTaskStatus.undefined;

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      id = data[0];
      context.read<DownloadingProgress>().setId(data[0]);
      status = data[1];
      context.read<DownloadingProgress>().setDownloadTaskStatus(data[1]);
      progress = data[2];
      context.read<DownloadingProgress>().setProgress(data[2]);
      if (progress == 100) {
        Timer(
          const Duration(seconds: 1),
          () => setState(() {
            progress = 0;
          }),
        );
      }
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

      final String _appName = name;

      if (File(externalDir.path + "/" + name + ".mp4").existsSync()) {
        for (int i = 1; i < 100; i++) {
          name = _appName + "(" + "$i" + ")";
          if (!File(externalDir.path + "/" + name + ".mp4").existsSync()) {
            break;
          }
        }
      }

      // download file name sequence logic ends here

      // ignore: unused_local_variable
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: name + '.mp4',
        savedDir: externalDir.path + "/",
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: false,
      );
    } else {
      debugPrint('Permission Denied');
    }
  }

  _downloadnCancelTask() {
    if (status == DownloadTaskStatus.undefined) {
      _download(
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
          widget.name);

      // _download(widget.icon, widget.name);
      // _download(widget.apkurl, "${widget.name}.apk");
      context.read<DownloadingProgress>().setAppName(widget.name);
    } else if (status == DownloadTaskStatus.running) {
      FlutterDownloader.cancel(taskId: id);
      context.read<DownloadingProgress>().setAppName("");
    }
  }

  @override
  Widget build(BuildContext context) {
    // download button styling fon inside text
    const _downloadButtonTextStyling = TextStyle(
      color: Colors.white,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: widget.icon,
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
                      onTap: _downloadnCancelTask,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 125,
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
                              child: status == DownloadTaskStatus.undefined
                                  ? const Text(
                                      "Download",
                                      style: _downloadButtonTextStyling,
                                    )
                                  : status == DownloadTaskStatus.running
                                      ? Row(
                                          children: [
                                            const Text("Downloading",
                                                style:
                                                    _downloadButtonTextStyling),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 4),
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.white,
                                                    width: 0.5,
                                                  ),
                                                ),
                                              ),
                                              padding: const EdgeInsets.all(6),
                                              child: const Text(
                                                "X",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                          ],
                                        )
                                      : status == DownloadTaskStatus.complete
                                          ? const Text("Downloaded",
                                              style: _downloadButtonTextStyling)
                                          : const Text("Download",
                                              style:
                                                  _downloadButtonTextStyling)),
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
