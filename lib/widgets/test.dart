import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  "Collapsing Toolbar",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ];
        },
        body: const Center(
          child: Text("Sample Text"),
        ),
      ),
    );
  }
}
