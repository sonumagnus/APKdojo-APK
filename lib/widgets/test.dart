import 'package:apkdojo/widgets/loading_animation_widgets/slug_animation.dart';
import 'package:apkdojo/widgets/star_rating.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late Future<Map> app;

  Future<Map> getApp() async {
    var response =
        await Dio().get('https://api.apkdojo.com/app.php?id=netflix&lang=en');
    return response.data;
  }

  @override
  void initState() {
    app = getApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Page"),
      ),
      body: const SlugLoadingAnimation(),
    );
  }
}
