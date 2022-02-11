import 'package:flutter/material.dart';
import 'package:apkdojo/widgets/featured_apps.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? const TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            : const Text("HomePage"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: isSearching
                  ? const Icon(Icons.cancel_outlined)
                  : const Icon(Icons.search))
        ],
      ),
      drawer: const Drawer(),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            const Text(
              "Editor's Choice",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text("Featured by APKdojo"), Text("See All")],
              ),
            ),
            const FeaturedApps()
          ],
        ),
      ),
    );
  }
}
