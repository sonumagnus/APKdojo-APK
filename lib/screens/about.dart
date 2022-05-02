import 'package:apkdojo/widgets/main_ui_widgets/custom_appbar.dart';
import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(AppBar().preferredSize.height, context, _scaffoldKey),
      drawer: const MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const AboutSectionHeading(
            heading: "/ About Us",
            fontSize: 22,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 25),
          ),
          const AboutSectionHeading(
            heading: "What is APKdojo?",
          ),
          const AboutSectionTextContent(
            content:
                "APKdojo is the place where you can download the Android APK with just a single click. We aim to provide a faster and secure apps downloading experience to all Android users. We are promised to offer you a free APK downloading platform with an intuitive and easy-to-use user interface where anyone can download their desired apps & games easily and quickly. Currently, APKdojo is one of the fastest APK downloading websites in the world",
          ),
          const AboutSectionHeading(heading: "Out Mission"),
          const AboutSectionTextContent(
            content:
                "We care for our user’s valuable time and that’s why APKdojo is designed to give you a faster APK downloading experience on your smartphone and tablet.\nRating is one of the things that helps any android user to find and download the best app for their smartphone and that’s why we provide a personalized and accurate rating system.\nAll the Apps and Games are completely free on APKdojo; Even you don’t need to Signup/login on the website to download the apps.",
          ),
          const AboutSectionHeading(heading: "Priority to Data Security"),
          const AboutSectionTextContent(
            content:
                "All the applications are virus and malware-free on APKdojo. Our technical team scans all the apps with multiple antivirus software before uploading them on the website.",
          ),
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AboutSectionHeading(
                  heading: "Notice",
                  textColor: Colors.white,
                ),
                AboutSectionTextContent(
                  contetTextColor: Colors.white,
                  content:
                      "APKdojo.com is NOT associated or affiliated with Google, Google Play or Android in any way. Android is a trademark of Google Inc. All the apps and games are property and trademark of their respective developer or publisher and for HOME or PERSONAL use ONLY. Please be aware that APKdojo.com ONLY SHARE THE ORIGINAL APK FILE FOR FREE APPS. ALL THE APK FILE IS THE SAME AS IN GOOGLE PLAY WITHOUT ANY CHEAT, UNLIMITED GOLD PATCH OR ANY OTHER MODIFICATIONS.",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AboutSectionTextContent extends StatelessWidget {
  final String content;
  final Color contetTextColor;
  const AboutSectionTextContent({
    Key? key,
    required this.content,
    this.contetTextColor = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: contetTextColor,
        ),
      ),
    );
  }
}

class AboutSectionHeading extends StatelessWidget {
  final String heading;
  final Color textColor;
  final double fontSize;
  const AboutSectionHeading({
    Key? key,
    required this.heading,
    this.textColor = Colors.black87,
    this.fontSize = 17.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Text(
        heading,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
