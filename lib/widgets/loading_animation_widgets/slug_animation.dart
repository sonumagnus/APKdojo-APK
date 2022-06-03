import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class SlugLoadingAnimation extends StatelessWidget {
  const SlugLoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        iconTheme: const IconThemeData(color: Vx.black),
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.cyan.shade100,
        highlightColor: Colors.grey.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxBox().square(80).gray300.roundedFull.margin(const EdgeInsets.only(right: 16)).make(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VxBox().size(250, 18).gray300.rounded.make(),
                VxBox().size(150, 16).gray300.rounded.margin(const EdgeInsets.symmetric(vertical: 10)).make(),
                VxBox().size(120, 34).gray300.roundedLg.make()
              ],
            )
          ],
        ).p20(),
      ),
    );
  }
}
