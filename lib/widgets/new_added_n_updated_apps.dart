import 'package:apkdojo/main.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_app_listing_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_horizonatal_app_tile.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NewAddedAndUpdatedApps extends HookWidget {
  final String applicationType;
  const NewAddedAndUpdatedApps({
    Key? key,
    required this.applicationType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appsList = useRef<List>([]);
    final apps = useState<Map>({});
    final _nextPage = useRef<int>(1);
    final _dioCacheManager = useRef<DioCacheManager>(
      DioCacheManager(CacheConfig()),
    );

    ScrollController _scrollController = useScrollController();

    void _fetchApps(int pageNum) async {
      if (_nextPage.value == apps.value['total_pages']) return;

      try {
        Options _cacheOptions = buildCacheOptions(
          const Duration(days: 7),
          forceRefresh: true,
        );
        Dio _dio = Dio();
        _dio.interceptors.add(_dioCacheManager.value.interceptor);
        Response _res = await _dio.get(
          'https://api.apkdojo.com/v-apps.php?type=$applicationType&lang=en&page=$pageNum',
          options: _cacheOptions,
        );
        apps.value = _res.data;
        _appsList.value.addAll(apps.value[applicationType]);
        _nextPage.value = _nextPage.value + 1;
      } catch (e) {
        // debugPrint(e.toString());
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
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        iconTheme: IconThemeData(color: iconThemeColor),
        title: Text(
          applicationType == "new_apps"
              ? "New Added and Updated Apps"
              : applicationType == "new_games"
                  ? "New Added and Updated Games"
                  : applicationType == "featured_apps"
                      ? "Editor's Choice"
                      : "",
          style: TextStyle(color: appBarTitleColor),
        ),
      ),
      body: _appsList.value.isEmpty
          ? const CategoryAppListingAnimation(animatedTileCount: 9)
          : SingleChildScrollView(
              controller: _scrollController,
              child: ListView(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _appsList.value.length,
                    itemBuilder: (context, index) {
                      return ListView(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          SingleHorizontalAppTile(
                            icon: _appsList.value[index]['icon'],
                            name: _appsList.value[index]['name'],
                            seourl: _appsList.value[index]['seourl'],
                          )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _nextPage.value != apps.value['total_pages']
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
