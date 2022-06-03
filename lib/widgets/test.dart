import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  "Collapsing Toolbar",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Consumer<DownloadingProgress>(builder: (context, value, child) {
          return Column(
            children: [
              Text("Progress is => ${value.progress}"),
              Text("DownloadTaskStatus is => ${value.downloadTaskStatus}"),
              Text("ID is => ${value.id}"),
              Text("AppName is => ${value.appName}"),
              ElevatedButton(
                  onPressed: () {
                    value.setAppName("whatsapp");
                    value.setDownloadTaskStatus(DownloadTaskStatus.paused);
                    value.setProgress(55);
                    value.setId("54ds4f54sdf");
                  },
                  child: "change state".text.make()),
              ElevatedButton(
                  onPressed: () {
                    value.setAppName("Messenger");
                    value.setDownloadTaskStatus(DownloadTaskStatus.running);
                    value.setProgress(85);
                    value.setId("4sd4f6s");
                  },
                  child: "change state 2".text.make()),
              ElevatedButton(
                  onPressed: () {
                    value.setDownloadingPSIN(0, DownloadTaskStatus.undefined, "", "");
                  },
                  child: const Text("Clean Global State"))
            ],
          );
        }),
      ),
    );
  }
}
