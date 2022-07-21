import 'package:apkdojo/providers/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SlugScreenshot extends StatelessWidget {
  final List screenshots;
  const SlugScreenshot({
    Key? key,
    required this.screenshots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          height: 240,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: ListView.builder(
            clipBehavior: Clip.none,
            itemCount: screenshots.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Container(
              margin: const EdgeInsets.only(right: 10),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ZoomedScreenshot(
                      screenshots: screenshots,
                      initalIndex: index,
                    ),
                  ),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    "assets/images/lazy_images/lazy-screen.jpg",
                  ),
                  imageUrl: screenshots[index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ZoomedScreenshot extends HookWidget {
  final List screenshots;
  final int initalIndex;
  const ZoomedScreenshot({
    Key? key,
    required this.screenshots,
    this.initalIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageController = usePageController(initialPage: initalIndex);
    var _selectedIndex = useState(initalIndex);

    List<Widget> _buildPageIndicator() {
      List<Widget> list = [];
      for (int i = 0; i < screenshots.length; i++) {
        list.add(i == _selectedIndex.value
            ? _singleDotIndicator(true)
            : _singleDotIndicator(false));
      }
      return list;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: screenshots.length,
            itemBuilder: (_, index) => CachedNetworkImage(
              imageUrl: screenshots[index],
            ),
            onPageChanged: (int currIndex) => _selectedIndex.value = currIndex,
          ),
          Positioned(
            bottom: 40,
            child: Row(children: _buildPageIndicator())
                .box
                .color(Colors.black45)
                .withRounded(value: 15)
                .p8
                .make(),
          )
        ],
      ),
    );
  }

  Widget _singleDotIndicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: const Color(0XFF2FB7B2).withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0.0, 0.0),
                  )
                : const BoxShadow(color: Colors.transparent)
          ],
          shape: BoxShape.circle,
          color: isActive ? const Color(0XFF6BC4C9) : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}
