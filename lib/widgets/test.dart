// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/material.dart';

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Installed Apps'),
//       ),
//       body: FutureBuilder<List<Application>>(
//         future: DeviceApps.getInstalledApplications(
//           onlyAppsWithLaunchIntent: true,
//           includeSystemApps: true,
//           includeAppIcons: true,
//         ),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Application>? data = snapshot.data;
//             // Sort the App List on Alphabetical Order
//             // ignore: avoid_single_cascade_in_expression_statements
//             data!
//               ..sort((app1, app2) => app1.appName
//                   .toLowerCase()
//                   .compareTo(app2.appName.toLowerCase()));
//             return ListView.separated(
//               padding: const EdgeInsets.only(left: 10),
//               itemCount: data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Application app = data[index];
//                 return ListTile(
//                   leading: app is ApplicationWithIcon
//                       ? Image.memory(app.icon, height: 40, width: 40)
//                       : null,
//                   title: Text(app.appName),
//                   subtitle: Text(app.packageName),
//                   onTap: () => DeviceApps.openApp(app.packageName),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider();
//               },
//             );
//           }
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello World"),
      ),
      body: Consumer<DownloadingProgress>(
        builder: (context, _downloadProgress, child) {
          return ListView(
            children: [
              // const Accordion(title: "hello world", content: "by"),
              TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.abc),
                label: const Text("data"),
              ),
              SvgPicture.asset(
                'assets/images/playstore.svg',
                height: 15,
              ),
              Text(context.read<DownloadingProgress>().progress.toString()),
              Text("${_downloadProgress.progress}"),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _downloadProgress.setProgress(_downloadProgress.progress + 1);
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    _downloadProgress.setProgress(
                        _downloadProgress.progress < 100
                            ? _downloadProgress.progress + 1
                            : 0);
                    _downloadProgress.setAppName(
                        "whatsapp messager discord - duolingo netflix battleground mobile india");
                  });
                },
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: () {
                  _downloadProgress.setProgress(0);
                  // context.read<DownloadingProgress>().setProgress(
                  //     context.read<DownloadingProgress>().progress + 1);
                },
                child: const Icon(Icons.remove),
              ),
            ],
          );
        },
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   final Dio dio = Dio();
//   bool loading = false;
//   double progress = 0;

//   Future<bool> downloadApp(String url, String fileName) async {
//     late Directory? directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();
//           String newPath = "";
//           // print(directory);
//           List<String> paths = directory!.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/APKdojo";
//           directory = Directory(newPath);
//         } else {
//           return false;
//         }
//       }
//       File saveFile = File(directory!.path + "/$fileName");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         await dio.download(
//           url,
//           saveFile.path,
//           onReceiveProgress: (received, total) {
//             setState(() {
//               progress = received / total;
//             });
//           },
//         );
//         return true;
//       }
//       return false;
//     } catch (e) {
//       debugPrint("$e");
//       return false;
//     }
//   }

//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }

//   downloadFile(String url, String name) async {
//     setState(() {
//       loading = true;
//       progress = 0;
//     });
//     bool downloaded = await downloadApp(url, name);
//     if (downloaded) {
//       debugPrint("File Downloaded");
//     } else {
//       debugPrint("Problem Downloading File");
//     }
//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: loading
//             ? Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: LinearProgressIndicator(
//                   minHeight: 10,
//                   value: progress,
//                 ),
//               )
//             : TextButton.icon(
//                 icon: const Icon(
//                   Icons.download_rounded,
//                 ),
//                 onPressed: () => downloadFile(
//                     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
//                     "myVideo.mp4"),
//                 label: const Text(
//                   "Download",
//                   style: TextStyle(fontSize: 25),
//                 ),
//               ),
//       ),
//     );
//   }
// }
