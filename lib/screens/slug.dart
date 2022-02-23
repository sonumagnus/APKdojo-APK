import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';

class Slug extends StatefulWidget {
  final String seourl;
  const Slug({Key? key, required this.seourl}) : super(key: key);

  @override
  State<Slug> createState() => _SlugState();
}

class _SlugState extends State<Slug> {
  late Future<Map> app;
  final List<bool> _isOpen = [true, false, false, false];

  Future<Map> fetchApp() async {
    var response = await Dio()
        .get('https://api.apkdojo.com/app.php?id=${widget.seourl}&lang=en');
    return response.data;
  }

  @override
  void initState() {
    setState(() {
      app = fetchApp();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.seourl),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<Map>(
          future: app,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.network(
                          snapshot.data!['icon'],
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!['name'],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(snapshot.data!['developer']),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Download"),
                          )
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(style: BorderStyle.solid),
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(snapshot.data!['rating']),
                                const Text('Rating'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Text(snapshot.data!['size']),
                              const Text('Size')
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Text(snapshot.data!['version']),
                              const Text("Version"),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Html(
                    data: snapshot.data!['des'],
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: snapshot.data!['screenshots'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, int index) {
                        return Image.network(
                            snapshot.data!['screenshots'][index]);
                      },
                    ),
                  ),
                  Container(
                    color: null,
                    child: ExpansionPanelList(
                      children: [
                        ExpansionPanel(
                            headerBuilder: (BuildContext context, isOpen) {
                              return const Text("User Review");
                            },
                            body: Text(snapshot.data!['reviews'][0]['rating']),
                            isExpanded: _isOpen[0]),
                        ExpansionPanel(
                            headerBuilder: (BuildContext context, isOpen) {
                              return const Text("APK Details");
                            },
                            body: const Text("hello"),
                            isExpanded: _isOpen[1]),
                        ExpansionPanel(
                            headerBuilder: (BuildContext context, isOpen) {
                              return const Text("What's New");
                            },
                            body: Text(snapshot.data!['whatsnew']),
                            isExpanded: _isOpen[2]),
                      ],
                      expansionCallback: (i, isOpen) => setState(() {
                        _isOpen[i] = !isOpen;
                      }),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
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
