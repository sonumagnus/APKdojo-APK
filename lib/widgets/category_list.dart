import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/category_app_listing.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_list_animation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';

class CategoryList extends StatefulWidget {
  final String type;
  final String cateListCount;
  const CategoryList({
    Key? key,
    required this.type,
    required this.cateListCount,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with AutomaticKeepAliveClientMixin<CategoryList> {
  late Future<List> categories;

  Future<List> getCategories() async {
    Response response = await Dio().get(
      "https://api.apkdojo.com/categories.php?type=${widget.type}&lang=en",
    );
    return response.data['results'];
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: p20),
      child: FutureBuilder<List>(
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
                        visualDensity: VisualDensity.compact,
                        dense: true,
                        horizontalTitleGap: 12,
                        contentPadding: const EdgeInsets.all(0),
                        leading: Image(
                          image: AssetImage(
                            'assets/images/category_icons/${snapshot.data![index]["caticon"]}.png',
                          ),
                          width: 26,
                          height: 26,
                        ),
                        title: Html(
                          data: snapshot.data![index]['catname'],
                          style: {
                            "*": Style(
                              fontSize: const FontSize(20),
                              fontWeight: FontWeight.w500,
                            ),
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Divider(
                          height: 2,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'fetching error ! Check Internet Connection',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return CategoryListAnimation(
            animatedTileCount: widget.cateListCount == 'categoryLength'
                ? 10
                : int.parse(widget.cateListCount),
          );
        },
      ),
    );
  }
}
