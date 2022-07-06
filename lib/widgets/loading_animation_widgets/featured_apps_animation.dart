import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class FeaturedAppAnimation extends StatelessWidget {
  final int animatedItemCount;
  const FeaturedAppAnimation({
    Key? key,
    this.animatedItemCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).textTheme.displayMedium!.color!,
      highlightColor: Theme.of(context).textTheme.displaySmall!.color!,
      child: GridView.builder(
        shrinkWrap: true,
        clipBehavior: Clip.none,
        itemCount: animatedItemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 2.9,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return const _SingleApp();
        },
      ).pOnly(left: 20),
    );
  }
}

class _SingleApp extends StatelessWidget {
  const _SingleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Vx.gray100,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }
}
