import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/widgets/category_app_listing.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_list_animation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CategoryList extends StatefulWidget {
  final String type;
  final String cateListCount;
  const CategoryList(
      {Key? key, required this.type, required this.cateListCount})
      : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List> categories;

  Future<List> getCategories() async {
    var response = await Dio().get(
        "https://api.apkdojo.com/categories.php?type=${widget.type}&lang=en");
    return response.data['results'];
  }

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.cateListCount == "categoryLength"
                ? snapshot.data!.length
                : int.parse(widget.cateListCount),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    createRouteRightToLeft(
                      targetRoute: CategoryAppListing(
                        applicationType: widget.type,
                        categoryName: snapshot.data![index]['caturl'],
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ListTile(
                      leading: Image(
                        image: AssetImage(
                            'assets/images/category_icons/${snapshot.data![index]["caticon"]}.png'),
                        width: 38,
                        height: 38,
                      ),
                      title: Text(
                        snapshot.data![index]['catname'],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CategoryListAnimation(
          animatedTileCount: widget.cateListCount == 'categoryLength'
              ? 10
              : int.parse(widget.cateListCount),
        );
      },
    );
  }
}
