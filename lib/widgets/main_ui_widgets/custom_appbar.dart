import 'package:apkdojo/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends StatelessWidget {
  final Widget child;
  const CustomAppBar({Key? key, this.child = const SizedBox()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  title: SvgPicture.asset("assets/images/apkdojoNameIcon.svg", width: 80.0).pSymmetric(h: 5),
                  expandedHeight: 110,
                  backgroundColor: Colors.white12,
                  bottom: PreferredSize(
                      preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchPage(),
                            ),
                          );
                        },
                        child: TextField(
                          enabled: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade500,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18),
                          ),
                        ).box.make().pSymmetric(h: 20),
                      )),
                )
              ];
            },
            body: child),
      ),
    ).box.white.make();
  }
}
