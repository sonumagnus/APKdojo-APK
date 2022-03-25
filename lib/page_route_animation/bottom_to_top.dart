import 'package:flutter/material.dart';

Route createRouteBottomToTop({required Widget targetRoute}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => targetRoute,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset(0.0, 0.5);
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
