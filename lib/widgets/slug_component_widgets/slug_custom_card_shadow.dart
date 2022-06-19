import 'package:flutter/material.dart';

class SlugCustomCardShadow extends StatelessWidget {
  final Widget child;
  final Offset offset;
  final EdgeInsetsGeometry margin;
  final double shadowBlurRadius, shadowSpreadRadius;
  final BlurStyle shadowBlurStyle;

  const SlugCustomCardShadow({
    Key? key,
    required this.child,
    this.offset = const Offset(0, 1),
    this.margin = const EdgeInsets.only(bottom: 10),
    this.shadowBlurRadius = 5,
    this.shadowSpreadRadius = 1,
    this.shadowBlurStyle = BlurStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        margin: margin,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              spreadRadius: shadowSpreadRadius,
              blurRadius: shadowBlurRadius,
              blurStyle: shadowBlurStyle,
              offset: offset,
              color: Theme.of(context).shadowColor,
            )
          ],
        ),
        child: child,
      );
    });
  }
}
