import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_app_listing_animation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:velocity_x/velocity_x.dart';
import 'main_ui_widgets/single_horizonatal_app_tile.dart';

class CategoryAppListing extends HookWidget {
  final String categoryName, applicationType, caturl;
  final AsyncSnapshot<List> categoryList;
  final int intitalIndex;
  const CategoryAppListing({
    Key? key,
    required this.categoryName,
    required this.applicationType,
    required this.caturl,
    required this.categoryList,
    required this.intitalIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabController _tabController = useTabController(
      initialLength: categoryList.data!.length,
      initialIndex: intitalIndex,
    );
    final _tabIndex = useState(true);

    _tabCallback() => _tabIndex.value = !_tabIndex.value;

    useEffect(() {
      _tabController.addListener(_tabCallback);
      return () => _tabController.removeListener(_tabCallback);
    });

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 100,
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: Theme.of(context).iconTheme,
            title: Html(
              data: categoryList.data![_tabController.index]['catname'],
              style: {
                "*": Style(
                  fontSize: const FontSize(20),
                  fontWeight: FontWeight.w600,
                  // color: Colors.grey.shade900,
                  margin: EdgeInsets.zero,
                )
              },
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.green.shade500,
              // labelColor: Colors.grey.shade900,
              // unselectedLabelColor: Colors.grey.shade600,
              tabs: categoryList.data!.map((e) => Tab(child: Text(e['catname']))).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: categoryList.data!.map((e) => CategoryBodyAppList(caturl: e['caturl'], applicationType: applicationType)).toList(),
        ),
      ),
    );
  }
}

class CategoryBodyAppList extends StatefulHookWidget {
  final String caturl, applicationType;
  const CategoryBodyAppList({
    Key? key,
    required this.caturl,
    required this.applicationType,
  }) : super(key: key);

  @override
  State<CategoryBodyAppList> createState() => _CategoryBodyAppListState();
}

class _CategoryBodyAppListState extends State<CategoryBodyAppList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final _appsList = useRef<List>([]);
    final _apps = useState<Map>({});
    final _nextPage = useRef<int>(1);

    ScrollController _scrollController = useScrollController();

    void _fetchApps(int pageNum) async {
      if (_nextPage.value - 1 == _apps.value['total_pages']) return;
      try {
        final String _api = '$apiDomain/category.php?id=${widget.caturl}&type=${widget.applicationType}&lang=en&page=$pageNum';
        Response _res = await Dio().get(_api);
        _apps.value = _res.data;
        _appsList.value.addAll(_apps.value['results']);
        _nextPage.value = _nextPage.value + 1;
      } catch (e) {
        // show error on screen
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

    return _appsList.value.isEmpty
        ? const CategoryAppListingAnimation(animatedTileCount: 9)
        : SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _appsList.value.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      SingleHorizontalAppTile(
                        icon: _appsList.value[index]['icon'],
                        name: _appsList.value[index]['name'],
                        seourl: _appsList.value[index]['seourl'],
                        developer: _appsList.value[index]['developer'],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _nextPage.value != _apps.value['total_pages'] + 1 ? const Center(child: CircularProgressIndicator()) : Chip(label: "No More Apps".text.medium.make()).centered(),
                )
              ],
            ),
          );
  }
}
