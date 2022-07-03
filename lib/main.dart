import 'package:apkdojo/providers/theme_provider.dart';
import 'package:apkdojo/widgets/my_behaviour.dart';
import 'package:flutter/material.dart';
import 'package:apkdojo/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:apkdojo/utils/check_permission_status.dart';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SingleAPkState>(
            create: (_) => SingleAPkState(),
          ),
        ],
        child: const ApkDojo(),
      ),
    );
  });
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
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          return Consumer<ThemeProvider>(
            builder: (context, value, child) {
              return MaterialApp(
                title: "Apkdojo",
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,
                themeMode: value.themeMode,
                home: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: const Home(),
                ),
              );
            },
          );
        },
      );
}
