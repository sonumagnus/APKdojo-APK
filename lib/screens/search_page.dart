import 'package:apkdojo/api/api.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        iconTheme: Theme.of(context).iconTheme,
        title: TextField(
          onChanged: (text) => _searchKeyword.value = text,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search Apps & Games",
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.grey.shade500,
              size: 25,
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
                      const Divider(height: 1)
                    ],
                  ),
                );
              },
            ),
    );
  }
}
