import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar basicAppBar({required String title, bool titleLeftSpacing = true}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 0,
    toolbarHeight: kToolbarHeight + 20,
    titleSpacing: titleLeftSpacing ? 20 : 0,
    title: title.text.size(25).bold.gray700.make(),
  );
}
