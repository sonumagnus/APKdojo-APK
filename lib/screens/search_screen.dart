import 'package:apkdojo/page_route_animation/right_to_left.dart';
import 'package:apkdojo/screens/slug.dart';
import 'package:apkdojo/widgets/main_ui_widgets/single_horizonatal_app_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../api/api.dart';

class SearchScreen extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Apps & Games";

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 17,
        color: Vx.gray400,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
                elevation: 0.0,
              ),
        );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) close(context, null);
          query = "";
        },
        icon: Icon(Icons.close, color: Colors.grey.shade600),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
    );
  }

  Future<List> _getAppsSuggestion() async {
    if (query.isEmpty) return [];
    try {
      String _api = "$apiDomain/search.php?q=$query";
      Response _response = await Dio().get(_api);
      return _response.data;
    } catch (e) {
      return [];
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List>(
      future: _getAppsSuggestion(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? "Oops ! No Such Apps".text.xl.medium.gray500.makeCentered()
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => SingleHorizontalAppTile(
                    seourl: snapshot.data![index]['seourl'],
                    icon: snapshot.data![index]['icon'],
                    name: snapshot.data![index]['name'],
                    developer: snapshot.data![index]['developer'],
                    showTrailing: false,
                  ),
                );
        } else if (snapshot.hasError) {
          return const Text("error");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List>(
      future: _getAppsSuggestion(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? "Search Apps & Games".text.xl.medium.color(Theme.of(context).textTheme.titleMedium!.color).makeCentered()
              : ListView.builder(
                  itemCount: snapshot.data!.length < 5 ? snapshot.data!.length : 5,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        createRouteRightToLeft(
                          targetRoute: Slug(
                            seourl: snapshot.data![index]['seourl'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.search, color: Theme.of(context).textTheme.titleMedium!.color),
                        title: "${snapshot.data![index]['name']}".text.lg.medium.color(Theme.of(context).textTheme.titleMedium!.color).make(),
                      ),
                    );
                  },
                );
        } else if (snapshot.hasError) {
          return const Text("Error in Loading suggestions");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
