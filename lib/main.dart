import 'package:apkdojo/home.dart';
import 'package:apkdojo/providers/dark_theme_toggle.dart';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

Color primaryColor = Colors.white;
Color iconThemeColor = Colors.black;
Color appBarTitleColor = Colors.black;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  runApp(
    MultiProvider(
      providers: [
        Provider<DownloadingProgress>(create: (_) => DownloadingProgress()),
        Provider<DarkThemeToggler>(create: (_) => DarkThemeToggler()),
      ],
      child: const ApkDojo(),
    ),
  );
}

class ApkDojo extends StatelessWidget {
  const ApkDojo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Apkdojo",
      home: const Home(),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
    );
  }
}
