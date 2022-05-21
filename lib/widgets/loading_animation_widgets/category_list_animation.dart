import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryListAnimation extends StatelessWidget {
  final int animatedTileCount;
  const CategoryListAnimation({Key? key, required this.animatedTileCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.cyan.shade100,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: animatedTileCount,
        itemBuilder: (context, index) => const SingleCategoryTile(),
      ),
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
      contentPadding: EdgeInsets.zero,
      leading: VxBox().square(40).gray500.roundedFull.make(),
      title: VxBox().height(20).gray500.rounded.make(),
    );
  }
}
