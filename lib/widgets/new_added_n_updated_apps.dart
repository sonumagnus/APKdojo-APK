import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/widgets/home_page_ui_widgets/app_type.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_app_listing_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_horizonatal_app_tile.dart';
import 'package:apkdojo/widgets/my_behaviour.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NewAddedAndUpdatedApps extends StatefulHookWidget {
  final String applicationType;
  const NewAddedAndUpdatedApps({Key? key, required this.applicationType}) : super(key: key);

  @override
  State<NewAddedAndUpdatedApps> createState() => _NewAddedAndUpdatedAppsState();
}

class _NewAddedAndUpdatedAppsState extends State<NewAddedAndUpdatedApps> {
  @override
  Widget build(BuildContext context) {
    final _appsList = useRef<List>([]);
    final apps = useState<Map>({});
    final _nextPage = useRef<int>(1);

    ScrollController _scrollController = useScrollController();

    void _fetchApps(int pageNum) async {
      if (_nextPage.value == apps.value['total_pages']) return;

      try {
        String _api = '$apiDomain/v-apps.php?type=${widget.applicationType}&lang=en&page=$pageNum';
        Response _res = await Dio().get(_api);
        apps.value = _res.data;
        _appsList.value.addAll(apps.value[widget.applicationType]);
        _nextPage.value = _nextPage.value + 1;
      } catch (e) {
        // debugPrint(e.toString());
      }
    }

    void _scrollerCallback() {
      if (_scrollController.position.pixels != _scrollController.position.maxScrollExtent) return;
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

    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: _appsList.value.isEmpty
            ? const CategoryAppListingAnimation(animatedTileCount: 9)
            : SingleChildScrollView(
                controller: _scrollController,
                child: ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    AppType(
                      mainHeading: widget.applicationType == "new_apps"
                          ? "New Added and Updated Apps"
                          : widget.applicationType == "new_games"
                              ? "New Added and Updated Games"
                              : widget.applicationType == "featured_apps"
                                  ? "Editor's Choice"
                                  : "",
                      followUpText: widget.applicationType == "new_games" ? "Games" : "Applications",
                      showSeeAll: false,
                    ),
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
                              developer: _appsList.value[index]['developer'],
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
