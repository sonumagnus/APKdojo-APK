import 'package:apkdojo/widgets/star_rating.dart';
import 'package:dio/dio.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:flutter/material.dart';

class FeaturedApps extends StatefulWidget {
  const FeaturedApps({Key? key}) : super(key: key);

  @override
  State<FeaturedApps> createState() => _FeaturedAppsState();
}

class _FeaturedAppsState extends State<FeaturedApps> {
  List featuredApps = [];

  fetchApps() async {
    var response = await Dio()
        .get('https://api.apkdojo.com/v-apps.php?type=featured_apps&lang=en');
    return response.data['featured_apps'];
  }

  @override
  void initState() {
    fetchApps().then((value) {
      setState(() {
        featuredApps = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: null,
      child: Container(
        color: null,
        height: 180,
        child: featuredApps.isNotEmpty
            ? GridView.builder(
                itemCount: featuredApps.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 10 / 6,
                    mainAxisSpacing: 12),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Slug(featuredApps[index]['seourl']),
                        ),
                      );
                    },
                    child: Container(
                      width: 80,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.lightGreen, Colors.lightBlueAccent],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            featuredApps[index]['icon'],
                            width: 80,
                          ),
                          Text(
                            featuredApps[index]['name'],
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[800],
                                overflow: TextOverflow.ellipsis),
                          ),
                          StarRating("${featuredApps[index]['star_rating']}"),
                        ],
                      ),
                    ),
                  );
                })
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
