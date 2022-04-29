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
                        AlwaysStoppedAnimation<Color>(Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${provider.progress < 100 ? "Downloading" : "Downloaded"} : ${provider.appName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade700),
                    ),
                  ),
                  Text("(${provider.progress}%)"),
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text("Cancel"),
                    ),
                    onTap: () {
                      FlutterDownloader.cancel(taskId: provider.id);
                      setState(() {
                        provider.setProgress(0);
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
