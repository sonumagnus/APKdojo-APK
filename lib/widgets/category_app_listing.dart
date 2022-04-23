import 'package:apkdojo/widgets/loading_animation_widgets/category_app_listing_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_appbar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_horizonatal_app_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryAppListing extends HookWidget {
  final String categoryName;
  final String applicationType;
  const CategoryAppListing({
    Key? key,
    required this.categoryName,
    required this.applicationType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appsList = useRef<List>([]);
    final apps = useState<Map>({});
    final _nextPage = useRef<int>(1);

    ScrollController _scrollController = useScrollController();

    void _fetchApps(int pageNum) async {
      if (_nextPage.value - 1 == apps.value['total_pages']) return;
      try {
        Response _res = await Dio().get(
          'https://api.apkdojo.com/category.php?id=$categoryName&type=$applicationType&lang=en&page=$pageNum',
        );
        apps.value = _res.data;
        _appsList.value.addAll(apps.value['results']);
        _nextPage.value = _nextPage.value + 1;
      } catch (e) {
        // show error on screen
      }
    }

    void _scrollerCallback() {
      if (_scrollController.position.pixels !=
          _scrollController.position.maxScrollExtent) return;
      _fetchApps(_nextPage.value);
    }

    useEffect(() {
      _scrollController.addListener(_scrollerCallback);
      return () => _scrollController.removeListener(_scrollerCallback);
    }, [_scrollController]);

    useEffect(() {
      _fetchApps(_nextPage.value);
      return null;
    }, []);

    return Scaffold(
      appBar: MyAppBar(
        appBarTitle: categoryName,
      ),
      body: _appsList.value.isEmpty
          ? const CategoryAppListingAnimation(
              animatedTileCount: 9,
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _appsList.value.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SingleHorizontalAppTile(
                            icon: _appsList.value[index]['icon'],
                            name: _appsList.value[index]['name'],
                            seourl: _appsList.value[index]['seourl'],
                            developer: _appsList.value[index]['developer'],
                          )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _nextPage.value != apps.value['total_pages'] + 1
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(
                            child: Chip(
                              label: Text(
                                "No More Data",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                  )
                ],
              ),
            ),
    );
  }
}
