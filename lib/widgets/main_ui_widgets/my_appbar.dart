import 'package:apkdojo/main.dart';
import 'package:apkdojo/widgets/main_ui_widgets/search_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitle;
  const MyAppBar({Key? key, required this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Html(
        data: appBarTitle,
        style: {
          "*": Style(
            fontSize: const FontSize(20),
            fontWeight: FontWeight.w600,
          )
        },
      ),
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: iconThemeColor),
      actions: const [SearchIconWidget()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
