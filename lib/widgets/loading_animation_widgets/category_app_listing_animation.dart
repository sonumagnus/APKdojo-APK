import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryAppListingAnimation extends StatelessWidget {
  final int animatedTileCount;
  const CategoryAppListingAnimation({Key? key, this.animatedTileCount = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).textTheme.displayMedium!.color!,
      highlightColor: Theme.of(context).textTheme.displaySmall!.color!,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: animatedTileCount,
        itemBuilder: (context, index) => const SingleAnimatedTile(),
      ),
    );
  }
}

class SingleAnimatedTile extends StatelessWidget {
  const SingleAnimatedTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: VxBox().square(44).gray500.roundedFull.make(),
      title: VxBox().height(20).rounded.gray500.make(),
    ).pSymmetric(v: 7);
  }
}
