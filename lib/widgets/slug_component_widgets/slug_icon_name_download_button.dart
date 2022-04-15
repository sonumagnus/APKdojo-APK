import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/share_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SlugIconNameDownloadButton extends StatefulWidget {
  final String icon;
  final String name;
  final String developer;
  final String developerUrl;
  final String seourl;
  final String apkurl;
  final String playStoreUrl;
  const SlugIconNameDownloadButton({
    Key? key,
    required this.icon,
    required this.name,
    required this.developer,
    required this.developerUrl,
    required this.seourl,
    required this.apkurl,
    this.playStoreUrl = "",
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
      if (status == DownloadTaskStatus.complete ||
          status == DownloadTaskStatus.canceled) {
        Timer(
          const Duration(seconds: 1),
          () => setState(
            () {
              progress = 0;
              status = DownloadTaskStatus.undefined;
              id = '';
              context.read<DownloadingProgress>().setAppName("");
            },
          ),
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
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        widget.name,
      );

      // _download(widget.icon, widget.name);
      // _download(widget.apkurl, "${widget.name}.apk");
      context.read<DownloadingProgress>().setAppName(widget.name);
    } else if (status == DownloadTaskStatus.running) {
      FlutterDownloader.cancel(taskId: id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: p20, right: p20, top: p20, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: widget.icon,
                width: 90,
                height: 90,
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
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Text(
                          "• ",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.developer,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                height: 1.25,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 2),
                      child: GestureDetector(
                        onTap: _downloadnCancelTask,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            widget.apkurl == ""
                                ? GetFromPlayStore(
                                    playStoreUrl: widget.playStoreUrl,
                                  )
                                : status == DownloadTaskStatus.undefined
                                    ? const DownloadButton(
                                        buttonText: "Download")
                                    : status == DownloadTaskStatus.running
                                        ? Container(
                                            alignment: Alignment.centerLeft,
                                            width: 120,
                                            child: SizedBox(
                                              height: 32,
                                              width: 32,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.grey.shade600,
                                                value:
                                                    double.parse("$progress") /
                                                        100,
                                              ),
                                            ),
                                          )
                                        : status == DownloadTaskStatus.complete
                                            ? const DownloadButton(
                                                buttonText: "Downloaded",
                                              )
                                            : status ==
                                                    DownloadTaskStatus.canceled
                                                ? const DownloadButton(
                                                    buttonText: "Canceled",
                                                  )
                                                : const DownloadButton(
                                                    buttonText: "Wait",
                                                  ),
                            // following code is for progress in percentage
                            if (status == DownloadTaskStatus.running)
                              Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Text(
                                  "$progress%",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            else
                              const SizedBox.shrink()
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
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                            ),
                            builder: (context) => buildSheet(),
                          );
                        },
                        child: const Icon(
                          Icons.share,
                          size: 20,
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
      ),
    );
  }
}

class DownloadButton extends StatelessWidget {
  final String buttonText;
  const DownloadButton({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      width: 120,
      height: 34,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFF34D399),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }
}

class GetFromPlayStore extends StatelessWidget {
  final String playStoreUrl;
  const GetFromPlayStore({
    Key? key,
    required this.playStoreUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(playStoreUrl)) {
          await launch(playStoreUrl);
        } else {
          // can lauch url
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/playstore.svg',
              height: 20,
            ),
            const SizedBox(
              width: 6,
            ),
            const Text(
              "Get From PlayStore",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SizedBox(
//                               height: 35,
//                               width: 120,
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(20),
//                                 ),
//                                 child: LinearProgressIndicator(
//                                   value: double.parse("$progress") / 100,
//                                   backgroundColor: const Color(0xFF34D399),
//                                   valueColor:
//                                       const AlwaysStoppedAnimation<Color>(
//                                     Colors.blue,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               child: status == DownloadTaskStatus.undefined
//                                   ? TextButton.icon(
//                                       onPressed: null,
//                                       icon: const Icon(
//                                         Icons.file_download_outlined,
//                                         color: Colors.white,
//                                       ),
//                                       label: const Text(
//                                         "download",
//                                         style: _downloadButtonTextStyling,
//                                       ),
//                                     )
//                                   : status == DownloadTaskStatus.running
//                                       ? Row(
//                                           children: [
//                                             const Text("Downloading",
//                                                 style:
//                                                     _downloadButtonTextStyling),
//                                             Container(
//                                               margin: const EdgeInsets.only(
//                                                   left: 4),
//                                               decoration: const BoxDecoration(
//                                                 color: Colors.green,
//                                                 border: Border(
//                                                   left: BorderSide(
//                                                     color: Colors.white,
//                                                     width: 0.5,
//                                                   ),
//                                                 ),
//                                               ),
//                                               padding: const EdgeInsets.all(6),
//                                               child: const Text(
//                                                 "X",
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                         FontWeight.w300),
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : status == DownloadTaskStatus.complete
//                                           ? const Text("Downloaded",
//                                               style: _downloadButtonTextStyling)
//                                           : const Text("Download",
//                                               style:
//                                                   _downloadButtonTextStyling),
//                             ),
