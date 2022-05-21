import 'package:apkdojo/providers/previous_download_status.dart';
import 'package:flutter/material.dart';
import 'package:apkdojo/home.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:apkdojo/common_methods/check_permission_status.dart';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DownloadingProgress>(
          create: (_) => DownloadingProgress(),
        ),
        ChangeNotifierProvider<PreviousDownloadStatus>(
          create: (_) => PreviousDownloadStatus(),
        ),
      ],
      child: const ApkDojo(),
    ),
  );
}

class ApkDojo extends StatefulWidget {
  const ApkDojo({Key? key}) : super(key: key);

  @override
  State<ApkDojo> createState() => _ApkDojoState();
}

class _ApkDojoState extends State<ApkDojo> {
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Apkdojo",
      home: Home(),
    );
  }
}
