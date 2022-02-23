import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedAppAnimation extends StatelessWidget {
  final int animatedItemCount;
  const FeaturedAppAnimation({Key? key, required this.animatedItemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.cyanAccent,
      highlightColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          childAspectRatio: 4 / 8,
          children: <Widget>[
            for (var i = 0; i < animatedItemCount; i++) const SingleApp()
          ],
        ),
      ),
    );
  }
}

class SingleApp extends StatelessWidget {
  const SingleApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
