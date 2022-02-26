import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const headingStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text("about page"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text("About Us", style: headingStyle),
          const Text("What is APKdojo ? ", style: headingStyle),
          const Text(
              "APKdojo is the place where you can download the Android APK with just a single click. We aim to provide a faster and secure apps downloading experience to all Android users. We are promised to offer you a free APK downloading platform with an intuitive and easy-to-use user interface where anyone can download their desired apps & games easily and quickly. Currently, APKdojo is one of the fastest APK downloading websites in the world"),
          const Text("Our Mission.", style: headingStyle),
          const Text(
              "We care for our user’s valuable time and that’s why APKdojo is designed to give you a faster APK downloading experience on your smartphone and tablet."),
          const Text(
              "Rating is one of the things that helps any android user to find and download the best app for their smartphone and that’s why we provide a personalized and accurate rating system."),
          const Text(
              "All the Apps and Games are completely free on APKdojo; Even you don’t need to Signup/login on the website to download the apps."),
          const Text("Priority to Data Security", style: headingStyle),
          const Text(
              "All the applications are virus and malware-free on APKdojo. Our technical team scans all the apps with multiple antivirus software before uploading them on the website."),
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(12),
            child: ListView(
              shrinkWrap: true,
              children: const [
                Text("Notice", style: headingStyle),
                Text(
                  "APKdojo.com is NOT associated or affiliated with Google, Google Play or Android in any way. Android is a trademark of Google Inc. All the apps and games are property and trademark of their respective developer or publisher and for HOME or PERSONAL use ONLY. Please be aware that APKdojo.com ONLY SHARE THE ORIGINAL APK FILE FOR FREE APPS. ALL THE APK FILE IS THE SAME AS IN GOOGLE PLAY WITHOUT ANY CHEAT, UNLIMITED GOLD PATCH OR ANY OTHER MODIFICATIONS.",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
