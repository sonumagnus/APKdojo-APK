import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/screens/search_screen.dart';
import 'package:apkdojo/widgets/dio_error_message.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_vertical_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DevProfileAndApps extends StatefulWidget {
  final String devURL;
  const DevProfileAndApps({Key? key, required this.devURL}) : super(key: key);

  @override
  _DevProfileAndAppsState createState() => _DevProfileAndAppsState();
}

class _DevProfileAndAppsState extends State<DevProfileAndApps> {
  late Future<Map> devInfo;

  Future<Map> getDevInfo() async {
    String _api = '$apiDomain/developer.php?dev=${widget.devURL}&lang=en';
    Response response = await Dio().get(_api);
    return response.data;
  }

  @override
  void initState() {
    devInfo = getDevInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme _txtTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: widget.devURL.text.color(_txtTheme.titleMedium!.color).make(),
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: SearchScreen()),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder<Map>(
        future: devInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
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
                              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.mail, color: Colors.green),
                                  const SizedBox(width: 5),
                                  "${snapshot.data!["apps_count"]} Apps".text.color(_txtTheme.titleMedium!.color).bold.make(),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.games, color: Colors.green),
                                  const SizedBox(width: 5),
                                  "${snapshot.data!['games_count']} Games".text.color(_txtTheme.titleMedium!.color).bold.make(),
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
                      "Application".text.xl.color(Theme.of(context).textTheme.titleLarge!.color).make().pSymmetric(h: 15, v: 8),
                      GridView.builder(
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                seourl: snapshot.data!['results'][index]['seourl'],
                                name: snapshot.data!['results'][index]['name'],
                                icon: snapshot.data!['results'][index]['icon'],
                                rating: snapshot.data!['results'][index]['rating'].toString(),
                                starRating: snapshot.data!['results'][index]['star_rating'].toString(),
                                index: index,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const DioErrorMessage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
