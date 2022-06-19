import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShowUpAnimation extends HookWidget {
  final bool activate;
  final Widget child;
  final Duration animationDuration;
  final Offset beginAnimOffset;
  final Curve curve;
  const ShowUpAnimation({
    Key? key,
    required this.activate,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 500),
    this.beginAnimOffset = const Offset(0.0, 0.65),
    this.curve = Curves.ease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _animController = useAnimationController(duration: animationDuration);

    final _curve = useMemoized(
      () => CurvedAnimation(parent: _animController, curve: curve),
    );

    final _animOffset = useMemoized(
      () => Tween<Offset>(begin: beginAnimOffset, end: Offset.zero).animate(_curve),
    );

    useEffect(() {
      activate ? _animController.forward() : _animController.reverse();
      return null;
    }, [activate]);

    return AnimatedBuilder(
      animation: _animController,
      child: child,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animController,
          child: SlideTransition(
            position: _animOffset,
            child: child,
          ),
        );
      },
    );
  }
}
