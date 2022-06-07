// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/providers/previous_download_status.dart';
import 'package:apkdojo/utils/app_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class DownloadButtonWithLogic extends StatefulWidget {
  final String name, apkurl, playStoreUrl, version;
  const DownloadButtonWithLogic({
    Key? key,
    required this.name,
    required this.apkurl,
    required this.version,
    this.playStoreUrl = "",
  }) : super(key: key);

  @override
  State<DownloadButtonWithLogic> createState() => _DownloadButtonWithLogicState();
}

class _DownloadButtonWithLogicState extends State<DownloadButtonWithLogic> {
  int progress = 0;
  String id = '';
  bool _apkAlreadyDownloaded = false;
  String _apkPath = ""; // in case app is already downloaded
  bool oldVersionAvailable = false;
  late DownloadTaskStatus status = DownloadTaskStatus.undefined;

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    isAlreadyDownloaded(widget.name, widget.version);

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) async {
      // settinng local state
      id = data[0];
      status = data[1];
      progress = data[2];

      // setting global state
      context.read<DownloadingProgress>().setDownloadingPSIN(data[2], data[1], data[0], widget.name);

      // resetting state on download complete or cancel
      if (status == DownloadTaskStatus.complete || status == DownloadTaskStatus.canceled) {
        Timer(
          const Duration(milliseconds: 10),
          () => setState(
            () {
              // Resetting local state after download complete or cancel
              progress = 0;
              status = DownloadTaskStatus.undefined;
              id = '';

              context.read<DownloadingProgress>().setDownloadingPSIN(0, DownloadTaskStatus.undefined, "", "");
            },
          ),
        );
      }
      setState(() {
        //this setState function updates local state continuously
      });

      // Apk is now downloaded
      if (status == DownloadTaskStatus.complete) {
        String _apkPath = await App.getApkPath(widget.name, widget.version);
        context.read<PreviousDownloadStatus>().setIsAppAlreadyDownloaded(true, apkPath: _apkPath);
        setState(() => _apkAlreadyDownloaded = true);
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  _downloadnCancelTask() {
    if (status == DownloadTaskStatus.undefined) {
      App.download(widget.apkurl, "${widget.name}_${widget.version}");
      context.read<DownloadingProgress>().setAppName(widget.name);
    } else if (status == DownloadTaskStatus.running) {
      FlutterDownloader.cancel(taskId: id);
    }
  }

  _downloadButtonGesture() {
    _apkAlreadyDownloaded && status != DownloadTaskStatus.running ? OpenFile.open(_apkPath) : _downloadnCancelTask();
  }

  void isAlreadyDownloaded(String name, String version) async {
    _apkPath = await App.getApkPath(name, version);

    if (File(_apkPath).existsSync()) {
      // setting global state if app is alredy downloaded
      context.read<PreviousDownloadStatus>().setIsAppAlreadyDownloaded(true, apkPath: _apkPath);
      // setting local state if app is already downloaded
      setState(() => _apkAlreadyDownloaded = true);
      return;
    }

    bool isOldVersionAvailable = await App.isOldVersionAlreadyAvaiable(name);

    if (isOldVersionAvailable) {
      context.read<PreviousDownloadStatus>().setIsAppAlreadyDownloaded(true, apkPath: _apkPath, isOldVersionAvailable: true);
      setState(() => oldVersionAvailable = true);
      return;
    }

    // setting global state if app is already not downloaded
    context.read<PreviousDownloadStatus>().setIsAppAlreadyDownloaded(false);
    // setting local state if app is already not downloaded
    setState(() => _apkAlreadyDownloaded = false);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadingProgress>(builder: (context, value, child) {
      return GestureDetector(
        onTap: _downloadButtonGesture,
        child: [
          if (_apkAlreadyDownloaded && status != DownloadTaskStatus.running)
            const Button(buttonText: "Open")
          else if (oldVersionAvailable && status == DownloadTaskStatus.undefined)
            const Button(buttonText: "Update")
          else if (widget.apkurl == "")
            GetFromPlayStore(playStoreUrl: widget.playStoreUrl)
          else if (status == DownloadTaskStatus.undefined || value.appName != widget.name)
            const Button(buttonText: "Download")
          else if (status == DownloadTaskStatus.running && value.appName == widget.name)
            CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.grey.shade600,
              value: double.parse("$progress") / 100,
            ).box.width(120).alignCenterLeft.make().box.square(32).make()
          else if (status == DownloadTaskStatus.complete)
            const Button(buttonText: "Downloaded")
          else if (status == DownloadTaskStatus.canceled)
            const Button(buttonText: "Canceled")
          else if (status == DownloadTaskStatus.failed)
            const Button(buttonText: "Failed"), // following code is for progress in percentage
          if (status == DownloadTaskStatus.running && value.appName == widget.name) "$progress%".text.sm.make().pOnly(left: 5) else const SizedBox.shrink()
        ].zStack(alignment: Alignment.centerLeft),
      ).pOnly(top: 2);
    });
  }
}

class Button extends StatelessWidget {
  final String buttonText;
  const Button({Key? key, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buttonText.text.white.bold.make().box.size(120, 34).alignCenter.green400.roundedLg.make();
  }
}

class GetFromPlayStore extends StatelessWidget {
  final String playStoreUrl;
  const GetFromPlayStore({Key? key, required this.playStoreUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(playStoreUrl)) {
          await launch(playStoreUrl);
        }
      },
      child: [
        SvgPicture.asset('assets/images/playstore.svg', height: 20),
        const WidthBox(6),
        "Get From PlayStore".text.white.sm.bold.make(),
      ].hStack().pSymmetric(h: 16, v: 6).box.black.roundedLg.make(),
    );
  }
}
