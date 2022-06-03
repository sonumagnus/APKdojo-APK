import 'package:apkdojo/api/api.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchPage extends HookWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchKeyword = useState<String>('');
    final _searchResult = useState<List>([]);

    void _getApps() async {
      if (_searchKeyword.value == '') return;
      try {
        String _api = "$apiDomain/search.php?q=${_searchKeyword.value}";
        Response res = await Dio().get(_api);
        _searchResult.value = res.data;
      } catch (e) {
        // debugPrint(e.toString());
      }
    }

    useEffect(() {
      _getApps();
      return null;
    }, [_searchKeyword.value]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: CustomColor.iconThemeColor),
        title: TextField(
          cursorColor: Colors.black54,
          onChanged: (text) => _searchKeyword.value = text,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Search Apps & Games",
            hintStyle: TextStyle(color: Colors.black54),
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      body: _searchResult.value.isEmpty
          ? const Center(child: Text("Search Apps & Games"))
          : ListView.builder(
              itemCount: _searchResult.value.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Slug(
                          seourl: _searchResult.value[index]['seourl'],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.network(
                          _searchResult.value[index]['icon'],
                          height: 48,
                          width: 48,
                        ),
                        title: Text(
                          _searchResult.value[index]['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          _searchResult.value[index]['developer'],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
