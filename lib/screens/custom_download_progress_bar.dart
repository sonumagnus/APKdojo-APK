import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

class CustomDownloadProgressBar extends StatefulWidget {
  const CustomDownloadProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDownloadProgressBar> createState() =>
      _CustomDownloadProgressBarState();
}

class _CustomDownloadProgressBarState extends State<CustomDownloadProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadingProgress>(
      builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 65,
              child: Card(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: LinearProgressIndicator(
                    value: provider.progress.toDouble() / 100,
                    backgroundColor: Colors.white,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green.shade300),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${provider.progress < 100 ? "Downloading" : "Downloaded"} : ${provider.appName} (${provider.progress}%)",
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                ),
                GestureDetector(
                  child: const Text("Cancel"),
                  onTap: () {
                    FlutterDownloader.cancel(taskId: provider.id);
                    setState(() {
                      provider.setProgress(0);
                    });
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
