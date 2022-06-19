// import 'package:apkdojo/animation/show_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Test extends HookWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    // final _animation = useAnimation(
    //   CurvedAnimation(parent: controller, curve: Curves.easeInOutBack),
    // );
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              controller.forward();
            },
            child: const Text("change icon"),
          ),
          TextButton(
            onPressed: () {
              controller.reverse();
            },
            child: const Text("change icon"),
          ),
          AnimatedIcon(icon: AnimatedIcons.list_view, progress: controller),
        ],
      ),
    );
  }
}
