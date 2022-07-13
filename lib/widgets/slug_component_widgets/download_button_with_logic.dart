import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/utils/app_methods.dart';
import 'package:apkdojo/utils/state_managment.dart';
import 'package:apkdojo/utils/xapk_installer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class DownloadButtonWithLogic extends StatefulWidget {
  final String name, apkurl, playStoreUrl, version, packageName, size;
  const DownloadButtonWithLogic({
    Key? key,
    required this.name,
    required this.apkurl,
    required this.version,
    required this.packageName,
    required this.size,
    this.playStoreUrl = "",
  }) : super(key: key);

  @override
  State<DownloadButtonWithLogic> createState() => _DownloadButtonWithLogicState();
}

class _DownloadButtonWithLogicState extends State<DownloadButtonWithLogic> with WidgetsBindingObserver {
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() => SlugStateManagments.checkIfAppInstalled(context, packageName: widget.packageName));
    }
  }

  final ReceivePort _port = ReceivePort();

  triggerAppInstallation() async {
    final String apkExtension = widget.apkurl.split("/").last.split(".").last;

    if (apkExtension == 'apk') {
      OpenFile.open(await App.getApkPath(apkName: widget.name));
    } else {
      XapkInstaller.install(apkPath: await App.getApksDirectory() + "/${widget.name.trim()}" + ".xapk");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SlugStateManagments.isDownloadednInstalled(
      context,
      name: widget.name,
      packageName: widget.packageName,
      version: widget.version,
    );

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen(
      (dynamic data) async {
        SingleAPkState globalState = context.read<SingleAPkState>();

        // setting directly global state
        globalState.setDownloadingPSIN(
          id: data[0],
          downloadTaskStatus: data[1],
          progress: data[2],
          downloadingApkName: widget.name,
        );

        // resetting state on download complete or cancel
        if (globalState.downloadTaskStatus == DownloadTaskStatus.complete ||
            globalState.downloadTaskStatus == DownloadTaskStatus.canceled ||
            globalState.downloadTaskStatus == DownloadTaskStatus.failed) {
          Future.delayed(
            const Duration(milliseconds: 1),
            () {
              // resetting Global state
              globalState.setDownloadingPSIN(progress: 0, downloadTaskStatus: DownloadTaskStatus.undefined, id: "", downloadingApkName: "");
            },
          );
        }

        // Apk is now downloaded
        if (globalState.downloadTaskStatus == DownloadTaskStatus.complete) {
          triggerAppInstallation();
          // setting Global State
          globalState.setIsAppAlreadyDownloaded(true);
        }
      },
    );
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleAPkState>(
      builder: (context, value, child) {
        bool downloadingRunning = value.downloadTaskStatus == DownloadTaskStatus.running;
        return GestureDetector(
          onTap: () => App.downloadButtonGesture(
            apkName: widget.name,
            apkUrl: widget.apkurl,
            globalState: value,
            packageName: widget.packageName,
          ),
          child: [
            if (value.isApkInstalled && !downloadingRunning)
              const Button(buttonText: "Open")
            else if (value.appAlreadyDownloaded && !downloadingRunning)
              const Button(buttonText: "Install")
            else if (value.isOldVersionAvailable && value.downloadTaskStatus == DownloadTaskStatus.undefined)
              const Button(buttonText: "Update")
            else if (widget.apkurl == "")
              GetFromPlayStore(playStoreUrl: widget.playStoreUrl)
            else if (value.downloadTaskStatus == DownloadTaskStatus.undefined || value.downloadingAppName != widget.name)
              const Button(buttonText: "Install", showDownloadIcon: true)
            else if (downloadingRunning && value.downloadingAppName == widget.name)
              downloadProgressWithCancelButton(value, context)
            else if (value.downloadTaskStatus == DownloadTaskStatus.complete)
              const Button(buttonText: "Downloaded")
            else if (value.downloadTaskStatus == DownloadTaskStatus.canceled)
              const Button(buttonText: "Canceled")
            else if (value.downloadTaskStatus == DownloadTaskStatus.failed)
              const Button(buttonText: "Failed"),
          ].vStack(crossAlignment: CrossAxisAlignment.start),
        ).pOnly(top: 2);
      },
    );
  }

  Widget downloadProgressWithCancelButton(SingleAPkState value, BuildContext context) {
    return SizedBox(
      height: 34,
      child: Row(
        children: [
          "${value.progress}% of ${widget.size}".text.color(Theme.of(context).textTheme.titleMedium!.color).make(),
          const SizedBox(width: 10),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => FlutterDownloader.cancel(taskId: value.id),
            icon: Icon(
              Icons.close_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            iconSize: 22,
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String buttonText;
  final bool showDownloadIcon;
  const Button({
    Key? key,
    required this.buttonText,
    this.showDownloadIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showDownloadIcon)
          SvgPicture.asset(
            "assets/images/download_icon.svg",
            height: 16,
            width: 16,
            color: Colors.white,
          ).pOnly(right: 6),
        buttonText.text.white.bold.make(),
      ],
    ).box.size(120, 34).alignCenter.color(Colors.green.shade500).roundedLg.make();
  }
}

class GetFromPlayStore extends StatelessWidget {
  final String playStoreUrl;
  const GetFromPlayStore({Key? key, required this.playStoreUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrlString(playStoreUrl)) {
          await launchUrlString(
            playStoreUrl,
            mode: LaunchMode.externalApplication,
          );
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
