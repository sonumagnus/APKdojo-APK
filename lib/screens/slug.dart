import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Slug extends StatefulWidget {
  final String seourl;
  const Slug(this.seourl, {Key? key}) : super(key: key);

  @override
  State<Slug> createState() => _SlugState();
}

class _SlugState extends State<Slug> {
  late Future<Map> app;

  Future<Map> fetchApp() async {
    var response = await Dio()
        .get('https://api.apkdojo.com/app.php?id=${widget.seourl}&lang=en');
    // print(response.data);
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
        child: Container(
          color: null,
          child: FutureBuilder<Map>(
            future: app,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data!['name']),
                    Image.network(snapshot.data!['icon']),
                    Text(snapshot.data.toString()),
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
      ),
    );
  }
}
