import 'package:apkdojo/widgets/main_ui_widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:velocity_x/velocity_x.dart';

class ModernDualTabBar extends HookWidget {
  final String firstTabName, secondTabName, appBarTitle;
  final Widget firstChild, secondChild;
  final int initialIndex;
  const ModernDualTabBar({
    Key? key,
    required this.firstTabName,
    required this.secondTabName,
    required this.firstChild,
    required this.secondChild,
    required this.appBarTitle,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = useTabController(initialLength: 2, initialIndex: initialIndex);
    final _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: basicAppBar(title: appBarTitle, context: context),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              color: Colors.transparent,
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 42,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).shadowColor),
                    BoxShadow(
                      color: _textTheme.displayMedium!.color!,
                      spreadRadius: -1.0,
                      blurRadius: 1.0,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                ),
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
                  labelColor: Theme.of(context).tabBarTheme.labelColor,
                  padding: const EdgeInsets.all(4.0),
                  indicator: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  tabs: [Tab(text: firstTabName), Tab(text: secondTabName)],
                ),
              ),
            ),
            SizedBox(
              width: context.mq.size.width,
              height: context.mq.size.height - kToolbarHeight - kBottomNavigationBarHeight - 114,
              child: TabBarView(
                controller: _tabController,
                children: [firstChild, secondChild],
              ),
            )
          ],
        ),
      ),
    );
  }
}
