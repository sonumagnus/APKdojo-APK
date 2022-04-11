import 'package:flutter/material.dart';

class SlugCustomCardShadow extends StatelessWidget {
  final Widget child;
  final Offset offset;
  final EdgeInsetsGeometry margin;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final Color shadowColor;
  final BlurStyle shadowBlurStyle;

  const SlugCustomCardShadow({
    Key? key,
    required this.child,
    this.offset = const Offset(0, 1),
    this.margin = const EdgeInsets.only(bottom: 10),
    this.shadowColor = Colors.black12,
    this.shadowBlurRadius = 5,
    this.shadowSpreadRadius = 1,
    this.shadowBlurStyle = BlurStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: shadowSpreadRadius,
            blurRadius: shadowBlurRadius,
            blurStyle: shadowBlurStyle,
            offset: offset,
            color: shadowColor,
          )
        ],
      ),
      child: child,
    );
  }
}
