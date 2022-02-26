import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryAppListingAnimation extends StatelessWidget {
  final int animatedTileCount;
  const CategoryAppListingAnimation({Key? key, required this.animatedTileCount})
      : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        title: Container(
          height: 20,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(6))),
        ),
        trailing: const Icon(
          Icons.download,
          size: 32,
          color: Colors.grey,
        ),
      ),
    );
  }
}
