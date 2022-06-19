import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeAppGridAnimation extends StatelessWidget {
  final int animatedItemCount;
  const HomeAppGridAnimation({
    Key? key,
    required this.animatedItemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).textTheme.displayMedium!.color!,
      highlightColor: Theme.of(context).textTheme.displaySmall!.color!,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
          shrinkWrap: true,
          clipBehavior: Clip.none,
          itemCount: animatedItemCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 16 / 19,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return const SingleApp();
          },
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
    const _boxDecoration = BoxDecoration(
      color: Colors.cyan,
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 68.33,
          width: 68.33,
          decoration: _boxDecoration,
        ),
        Container(
          decoration: _boxDecoration,
          height: 8,
          width: 68.3,
        ),
        Container(
          decoration: _boxDecoration,
          height: 6,
          width: 42.0,
        ),
      ],
    );
  }
}
