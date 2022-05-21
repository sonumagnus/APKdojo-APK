import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CollapsingAppBar extends StatelessWidget {
  final String heading;
  const CollapsingAppBar({
    Key? key,
    this.heading = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      expandedHeight: 100,
      pinned: true,
      floating: false,
      iconTheme: const IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.2,
        titlePadding: const EdgeInsets.only(left: 40, bottom: 8),
        title: Html(
          data: heading,
          style: {
            "*": Style(
              fontSize: const FontSize(20),
              fontWeight: FontWeight.w800,
              color: Colors.grey.shade600,
            ),
          },
        ),
      ),
    );
  }
}
