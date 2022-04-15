import 'package:apkdojo/main.dart';
import 'package:flutter/material.dart';

class AppBarWithoutSearch extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitle;
  const AppBarWithoutSearch({Key? key, this.appBarTitle = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text(
        appBarTitle,
        style: TextStyle(color: appBarTitleColor),
      ),
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: iconThemeColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
