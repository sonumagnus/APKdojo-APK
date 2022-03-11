import 'package:apkdojo/widgets/loading_animation_widgets/category_app_listing_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_horizonatal_app_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Test extends HookWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appsList = useRef<List>([]);
    final apps = useState<Map>({});
    final _nextPage = useRef<int>(1);
    ScrollController _scrollController = useScrollController();

    void _fetchApps(int pageNum) async {
      if (_nextPage.value == apps.value['total_pages']) return;
      var _res = await Dio().get(
          'https://api.apkdojo.com/category.php?id=education&type=apps&lang=en&page=$pageNum');
      apps.value = _res.data;
      appsList.value.addAll(apps.value['results']);
      debugPrint(appsList.value.toString());
      _nextPage.value = _nextPage.value + 1;
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
        title: const Text("Infinite scroll testing"),
      ),
      body: appsList.value.isEmpty
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
                    itemCount: appsList.value.length,
                    itemBuilder: (context, index) {
                      return ListView(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          SingleHorizontalAppTile(
                            icon: appsList.value[index]['icon'],
                            name: appsList.value[index]['name'],
                            seourl: appsList.value[index]['seourl'],
                          )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _nextPage.value != apps.value['total_pages']
                        ? const Center(child: CircularProgressIndicator())
                        : const Text("No More Data"),
                  )
                ],
              ),
            ),
    );
  }
}
