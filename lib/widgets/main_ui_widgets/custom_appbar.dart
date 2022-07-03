// This is HomePage Header which containes ApkDojo Svg Logo and Theme toggler button with disabled search field.

import 'package:apkdojo/providers/theme_provider.dart';
import 'package:apkdojo/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends StatelessWidget {
  final Widget child;
  const CustomAppBar({Key? key, this.child = const SizedBox()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    elevation: 0,
                    title: Consumer<ThemeProvider>(
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/images/apkdojoNameIcon.svg",
                              color: Theme.of(context).textTheme.labelMedium!.color,
                              width: 80.0,
                            ).pSymmetric(h: 5),
                            Switch.adaptive(
                              value: value.isDarkMode,
                              onChanged: (newState) => value.toggleTheme(newState),
                            ),
                          ],
                        );
                      },
                    ),
                    expandedHeight: 110,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    bottom: PreferredSize(
                      preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
                      child: GestureDetector(
                        onTap: () => showSearch(
                          context: context,
                          delegate: SearchScreen(),
                        ),
                        child: TextField(
                          enabled: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            filled: true,
                            // fillColor: Colors.grey.shade100,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade500,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 18,
                            ),
                          ),
                        ).box.make().pSymmetric(h: 20),
                      ),
                    ),
                  ),
                ],
            body: child),
      ).box.white.make(),
    );
  }
}
