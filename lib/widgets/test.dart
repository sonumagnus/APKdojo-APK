import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Test extends HookWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final featuredApps = useState([]);

    fetchApps() async {
      var _res = await Dio()
          .get("https://api.apkdojo.com/v-apps.php?type=featured_apps&lang=en");
      featuredApps.value.addAll(_res.data["featured_apps"]);
    }

    useEffect(() {
      fetchApps();
    }, []);
    return Material(
      child: SizedBox(
        height: 180,
        child: featuredApps.value.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Text(featuredApps.value[0].toString()),
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
//         await dio.download(url, saveFile.path,
//             onReceiveProgress: (received, total) {
//           setState(() {
//             progress = received / total;
//           });
//         });
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print(e);
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
