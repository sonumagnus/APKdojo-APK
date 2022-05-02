import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:apkdojo/common_methods/filepath_to_filename.dart';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/share_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
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
  final String version;
  const SlugIconNameDownloadButton({
    Key? key,
    required this.icon,
    required this.name,
    required this.developer,
    required this.developerUrl,
    required this.seourl,
    required this.apkurl,
    required this.version,
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
  bool _apkAlreadyDownloaded = false;
  String _apkPath = ""; //in case app is already downloaded
  late List<FileSystemEntity> _allFiles;
  late List<FileSystemEntity> _apkFiles;
  bool oldVersionAvailable = false;
  late DownloadTaskStatus status = DownloadTaskStatus.undefined;

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    isAlreadyDownloaded(widget.name, widget.version);

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      id = data[0];
      context.read<DownloadingProgress>().setId(data[0]);
      status = data[1];
      context.read<DownloadingProgress>().setDownloadTaskStatus(data[1]);
      progress = data[2];
      context.read<DownloadingProgress>().setProgress(data[2]);
      // resetting state on download complete or cancel
      if (status == DownloadTaskStatus.complete ||
          status == DownloadTaskStatus.canceled) {
        Timer(
          const Duration(milliseconds: 10),
          () => setState(
            () {
              // Resetting local state after download complete or cancel
              progress = 0;
              status = DownloadTaskStatus.undefined;
              id = '';

              // resetting global state after download complete or cancel
              context.read<DownloadingProgress>().setProgress(0);
              context
                  .read<DownloadingProgress>()
                  .setDownloadTaskStatus(DownloadTaskStatus.undefined);
              context.read<DownloadingProgress>().setId("");
              context.read<DownloadingProgress>().setAppName("");

              // Apk is now downloaded
            },
          ),
        );
      }
      setState(() {});
      if (status == DownloadTaskStatus.complete) {
        setState(() {
          _apkAlreadyDownloaded = true;
        });
      }
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

      // ignore: unused_local_variable
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: name + '.apk',
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
      _download(widget.apkurl, "${widget.name}_${widget.version}");
      context.read<DownloadingProgress>().setAppName(widget.name);
    } else if (status == DownloadTaskStatus.running) {
      FlutterDownloader.cancel(taskId: id);
    }
  }

  _downloadButtonGesture() {
    if (_apkAlreadyDownloaded) {
      OpenFile.open(_apkPath);
    } else {
      _downloadnCancelTask();
    }
  }

  void isAlreadyDownloaded(String name, String version) async {
    Directory? directory = await getExternalStorageDirectory();

    List<String> path = directory!.path.split("/");
    for (int x = 1; x < path.length; x++) {
      String folder = path[x];
      if (folder != "Android") {
        _apkPath += "/" + folder;
      } else {
        break;
      }
    }

    String _apkListPath = _apkPath + "/APKdojo";
    _apkPath = _apkPath + "/APKdojo" + "/" + name + "_" + version + ".apk";

    directory = Directory(_apkListPath);

    final dir = directory.path;
    String apkDirectory = '$dir/';
    final myDir = Directory(apkDirectory);
    _allFiles = myDir.listSync(recursive: true, followLinks: true);
    setState(() {
      _apkFiles =
          _allFiles.where((element) => element.path.endsWith('.apk')).toList();
    });

    if (File(_apkPath).existsSync()) {
      setState(() {
        _apkAlreadyDownloaded = true;
      });
      return;
    }

    for (int i = 0; i < _apkFiles.length; i++) {
      String _apkNameWithVersion = fileName(_apkFiles[i].path);
      bool _isContainsName = _apkNameWithVersion.contains(widget.name);
      if (_isContainsName) {
        oldVersionAvailable = _isContainsName;
      }
    }

    setState(() {
      _apkAlreadyDownloaded = false;
    });
    return;
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
                placeholder: (context, url) => Image.asset(
                  "assets/images/lazy_images/lazy-image.jpg",
                ),
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
                          child: Html(
                            data: widget.developer,
                            style: {
                              "*": Style(
                                margin: EdgeInsets.zero,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            },
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
                        onTap: _downloadButtonGesture,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            _apkAlreadyDownloaded
                                ? const DownloadButton(buttonText: "Open")
                                : oldVersionAvailable &&
                                        status == DownloadTaskStatus.undefined
                                    ? const DownloadButton(buttonText: "Update")
                                    : widget.apkurl == ""
                                        ? GetFromPlayStore(
                                            playStoreUrl: widget.playStoreUrl,
                                          )
                                        : status == DownloadTaskStatus.undefined
                                            ? const DownloadButton(
                                                buttonText: "Download",
                                              )
                                            : status ==
                                                    DownloadTaskStatus.running
                                                ? Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: 120,
                                                    child: SizedBox(
                                                      height: 32,
                                                      width: 32,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Colors
                                                            .grey.shade600,
                                                        value: double.parse(
                                                                "$progress") /
                                                            100,
                                                      ),
                                                    ),
                                                  )
                                                : status ==
                                                        DownloadTaskStatus
                                                            .complete
                                                    ? const DownloadButton(
                                                        buttonText:
                                                            "Downloaded",
                                                      )
                                                    : status ==
                                                            DownloadTaskStatus
                                                                .canceled
                                                        ? const DownloadButton(
                                                            buttonText:
                                                                "Canceled",
                                                          )
                                                        : status ==
                                                                DownloadTaskStatus
                                                                    .failed
                                                            ? const DownloadButton(
                                                                buttonText:
                                                                    "Failed",
                                                              )
                                                            : const DownloadButton(
                                                                buttonText:
                                                                    "Download"),
                            // following code is for progress in percentage
                            if (status == DownloadTaskStatus.running)
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
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
          fontWeight: FontWeight.bold,
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
