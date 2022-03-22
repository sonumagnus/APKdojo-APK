import 'package:apkdojo/main.dart';
import 'package:apkdojo/screens/slug.dart';
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
        var res = await Dio().get(
            "https://api.apkdojo.com/search.php?q=${_searchKeyword.value}");
        _searchResult.value = res.data;
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    useEffect(() {
      _getApps();
    }, [_searchKeyword.value]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        iconTheme: IconThemeData(color: iconThemeColor),
        title: TextField(
          cursorColor: Colors.black54,
          onChanged: (text) {
            _searchKeyword.value = text;
          },
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Search Apps & Games",
            hintStyle: TextStyle(
              color: Colors.black54,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
            ),
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
                  child: Card(
                    child: ListTile(
                      leading:
                          Image.network(_searchResult.value[index]['icon']),
                      title: Text(_searchResult.value[index]['name']),
                      subtitle: Text(_searchResult.value[index]['developer']),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
