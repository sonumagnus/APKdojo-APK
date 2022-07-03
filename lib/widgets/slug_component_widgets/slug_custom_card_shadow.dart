import 'package:flutter/material.dart';

class SlugCustomCardShadow extends StatelessWidget {
  final Widget child;
  final Offset offset;
  final EdgeInsetsGeometry margin;
  final double shadowBlurRadius, shadowSpreadRadius;
  final BlurStyle shadowBlurStyle;
  final bool hideUpshadow;

  const SlugCustomCardShadow(
      {Key? key,
      required this.child,
      this.offset = const Offset(0, -1),
      this.margin = const EdgeInsets.only(top: 10),
      this.shadowBlurRadius = 5,
      this.shadowSpreadRadius = 1,
      this.shadowBlurStyle = BlurStyle.normal,
      this.hideUpshadow = false})
      : super(key: key);

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
            ),
            if (hideUpshadow)
              BoxShadow(
                spreadRadius: 0,
                blurRadius: 0,
                blurStyle: shadowBlurStyle,
                offset: const Offset(0, -8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
          ],
        ),
        child: child,
      );
    });
  }
}
