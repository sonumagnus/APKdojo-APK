import 'package:apkdojo/widgets/loading_animation_widgets/featured_apps_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Test extends HookWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const FeaturedAppAnimation(),
    );
  }
}
