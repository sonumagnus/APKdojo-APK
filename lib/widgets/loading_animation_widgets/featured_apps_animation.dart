import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedAppAnimation extends StatelessWidget {
  final int animatedItemCount;
  const FeaturedAppAnimation({
    Key? key,
    this.animatedItemCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.cyan.shade100,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              itemCount: animatedItemCount,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 2.9,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return const _SingleApp();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SingleApp extends StatelessWidget {
  const _SingleApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
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
