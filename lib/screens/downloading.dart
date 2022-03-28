// Unused page

import 'package:apkdojo/widgets/download_page_app_suggestions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Download extends StatefulWidget {
  final String seourl;
  const Download({Key? key, required this.seourl}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  late Future<Map> appDetail;

  Future<Map> getAppDetail() async {
    var respose = await Dio().get(
        'https://api.apkdojo.com/app-download.php?id=${widget.seourl}&lang=en');
    return respose.data;
  }

  @override
  void initState() {
    appDetail = getAppDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donwload - ${widget.seourl}"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map>(
          future: appDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Image.network(
                      snapshot.data!['icon'],
                      height: 120,
                    ),
                  ),
                  Text(
                    snapshot.data!['name'],
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Click here if the download doesn't start automatically",
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(snapshot.data!['size']),
                      Text(snapshot.data!['version']),
                    ],
                  ),
                  DownloadPageAppSugesion(
                      relatedAppList: snapshot.data!['related'])
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
