import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar basicAppBar({required String title, bool titleLeftSpacing = true, required BuildContext context}) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    iconTheme: Theme.of(context).iconTheme,
    elevation: 0,
    toolbarHeight: kToolbarHeight + 20,
    titleSpacing: titleLeftSpacing ? 20 : 0,
    title: title.text.size(25).color(Theme.of(context).textTheme.titleLarge!.color).make(),
  );
}
