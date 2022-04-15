import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryAppListingAnimation extends StatelessWidget {
  final int animatedTileCount;
  const CategoryAppListingAnimation({
    Key? key,
    this.animatedTileCount = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.cyan.shade100,
      highlightColor: Colors.grey.shade100,
      child: ListView(
        shrinkWrap: true,
        children: [
          for (var i = 0; i < animatedTileCount; i++) const SingleAnimatedTile()
        ],
      ),
    );
  }
}

class SingleAnimatedTile extends StatelessWidget {
  const SingleAnimatedTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _boxDecoration =
        BoxDecoration(color: Colors.grey, shape: BoxShape.circle);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: _boxDecoration,
        ),
        title: Container(
          height: 20,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
