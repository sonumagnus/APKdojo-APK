import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SlugLoadingAnimation extends StatelessWidget {
  const SlugLoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.cyan.shade100,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 18,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 150,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
