import 'package:apkdojo/main.dart';
import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/widgets/loading_animation_widgets/category_list_animation.dart';
import 'package:apkdojo/widgets/main_ui_widgets/search_icon_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Developers extends HookWidget {
  const Developers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _devList = useRef<List>([]);
    final _devs = useState<Map>({});
    final _nextPage = useRef<int>(1);

    ScrollController _scrollController = useScrollController();

    void _fetchApps(int pageNum) async {
      if (_nextPage.value == _devs.value['total_pages']) return;

      try {
        var _res = await Dio()
            .get('https://api.apkdojo.com/developers.php?page=$pageNum');
        _devs.value = _res.data;
        _devList.value.addAll(_devs.value['results']);
        _nextPage.value = _nextPage.value + 1;
      } catch (e) {
        debugPrint(e.toString());
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
        elevation: 1,
        title: Text(
          "Developers",
          style: TextStyle(color: appBarTitleColor),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: iconThemeColor),
        actions: const [SearchIconWidget()],
      ),
      body: _devList.value.isEmpty
          ? const CategoryListAnimation(
              animatedTileCount: 12,
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _devList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
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
                        child: ListTile(
                          leading: Text(
                            _devList.value[index]['alpha'],
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            _devList.value[index]['name'],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
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
    );
  }
}

// import 'package:apkdojo/main.dart';
// import 'package:apkdojo/screens/devprofile.dart';
// import 'package:apkdojo/widgets/loading_animation_widgets/category_list_animation.dart';
// import 'package:apkdojo/widgets/main_ui_widgets/search_icon_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// class Developers extends StatefulWidget {
//   const Developers({Key? key}) : super(key: key);

//   @override
//   State<Developers> createState() => _DevelopersState();
// }

// class _DevelopersState extends State<Developers> {
//   late Future<List> developers;

//   Future<List> getDevelopers() async {
//     var response =
//         await Dio().get('https://api.apkdojo.com/developers.php?page=1');
//     return response.data['results'];
//   }

//   @override
//   void initState() {
//     developers = getDevelopers();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         title: Text(
//           "Developers",
//           style: TextStyle(color: appBarTitleColor),
//         ),
//         backgroundColor: primaryColor,
//         iconTheme: IconThemeData(color: iconThemeColor),
//         actions: const [SearchIconWidget()],
//       ),
//       body: FutureBuilder<List>(
//         future: developers,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DevProfileAndApps(
//                           devURL: snapshot.data![index]['url'],
//                         ),
//                       ),
//                     );
//                   },
//                   child: ListTile(
//                     leading: Text(
//                       snapshot.data![index]['alpha'],
//                       style: const TextStyle(
//                           fontSize: 25, fontWeight: FontWeight.bold),
//                     ),
//                     title: Text(
//                       snapshot.data![index]['name'],
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           }
//           return const CategoryListAnimation(
//             animatedTileCount: 5,
//           );
//         },
//       ),
//     );
//   }
// }
