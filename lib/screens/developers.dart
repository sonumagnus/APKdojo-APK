import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/widgets/home_page_ui_widgets/app_type.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_list_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/custom_appbar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Developers extends StatefulHookWidget {
  const Developers({Key? key}) : super(key: key);

  @override
  State<Developers> createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final _devList = useRef<List>([]);
    final _devs = useState<Map>({});
    final _nextPage = useRef<int>(1);

    ScrollController _scrollController = useScrollController();

    void _fetchApps(int pageNum) async {
      if (_nextPage.value - 1 == _devs.value['total_pages']) return;

      try {
        Response _res = await Dio().get(
          'https://api.apkdojo.com/developers.php?page=$pageNum',
        );
        _devs.value = _res.data;
        _devList.value.addAll(_devs.value['results']);
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
      return null;
    }, []);

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(AppBar().preferredSize.height, context, _scaffoldKey),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _devList.value.isEmpty
            ? const CategoryListAnimation(
                animatedTileCount: 12,
              )
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const AppType(
                      mainHeading: "Developers",
                      followUpText: "Apps & Game Creators",
                      showSeeAll: false,
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _devList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DevProfileAndApps(
                                      devURL: _devList.value[index]['url'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  leading: Text(
                                    _devList.value[index]['alpha'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  title: Text(
                                    _devList.value[index]['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12)
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _nextPage.value != _devs.value['total_pages']
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
      ),
    );
  }
}
