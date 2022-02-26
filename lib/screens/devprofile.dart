import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DevProfileAndApps extends StatefulWidget {
  final String devURL;
  const DevProfileAndApps({Key? key, required this.devURL}) : super(key: key);

  @override
  _DevProfileAndAppsState createState() => _DevProfileAndAppsState();
}

class _DevProfileAndAppsState extends State<DevProfileAndApps> {
  late Future<Map> devInfo;

  Future<Map> getDevInfo() async {
    var response = await Dio().get(
        'https://api.apkdojo.com/developer.php?dev=${widget.devURL}&lang=en');
    return response.data;
  }

  @override
  void initState() {
    devInfo = getDevInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.devURL),
      ),
      body: FutureBuilder<Map>(
        future: devInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  color: null,
                  height: 200,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.cyan,
                          ),
                          height: 100,
                          child: Text(
                            snapshot.data!['alpha'],
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.mail, color: Colors.green),
                                Text(
                                  snapshot.data!['apps_count'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(" Apps")
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.games, color: Colors.green),
                                Text(
                                  snapshot.data!['games_count'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(" Games")
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Application",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    GridView.builder(
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.all(12),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        childAspectRatio: 6 / 10,
                      ),
                      itemCount: snapshot.data!['results'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleVerticalApp(
                                seourl: snapshot.data!['results'][index]
                                    ['seourl'],
                                name: snapshot.data!['results'][index]['name'],
                                icon: snapshot.data!['results'][index]['icon'],
                                starRating:
                                    "${snapshot.data!['results'][index]['star_rating']}")
                          ],
                        );
                      },
                    ),
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
