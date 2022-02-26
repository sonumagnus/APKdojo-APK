import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_list_animation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Developers extends StatefulWidget {
  const Developers({Key? key}) : super(key: key);

  @override
  State<Developers> createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  late Future<List> developers;

  Future<List> getDevelopers() async {
    var response =
        await Dio().get('https://api.apkdojo.com/developers.php?page=1');
    return response.data['results'];
  }

  @override
  void initState() {
    developers = getDevelopers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developers"),
      ),
      body: FutureBuilder<List>(
        future: developers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DevProfileAndApps(
                          devURL: snapshot.data![index]['url'],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Text(
                      snapshot.data![index]['alpha'],
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      snapshot.data![index]['name'],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CategoryListAnimation(
            animatedTileCount: 5,
          );
        },
      ),
    );
  }
}
