import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/widgets/category_app_listing.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_list_animation.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
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
  late DioCacheManager _dioCacheManager;

  late Future<List> categories;

  Future<List> getCategories() async {
    _dioCacheManager = DioCacheManager(CacheConfig());

    Options _cacheOptions =
        buildCacheOptions(const Duration(days: 7), forceRefresh: true);
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await _dio.get(
        "https://api.apkdojo.com/categories.php?type=${widget.type}&lang=en",
        options: _cacheOptions);
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
                      title: Text(
                        snapshot.data![index]['catname'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 7,
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
    );
  }
}
