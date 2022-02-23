import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryListAnimation extends StatelessWidget {
  final int animatedTileCount;
  const CategoryListAnimation({Key? key, required this.animatedTileCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.cyanAccent,
      highlightColor: Colors.black12,
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              for (int i = 0; i < animatedTileCount; i++)
                const SingleCategoryTile(),
            ],
          )),
    );
  }
}

class SingleCategoryTile extends StatelessWidget {
  const SingleCategoryTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration:
            const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      ),
      title: Container(
        height: 16,
        decoration: const BoxDecoration(color: Colors.red),
      ),
    );
  }
}
