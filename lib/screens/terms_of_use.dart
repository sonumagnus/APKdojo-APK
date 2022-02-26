import 'package:flutter/material.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const headingStyles = TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );

    const paragraphStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms of Use"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const [
            Text("Terms of Use", style: headingStyles),
            Text(
                "At APKdojo, We solely intend to provide you with free android APK's for mobile apps and to use our free service; we require our users to abide by a few terms and conditions listed below. Please do note that these terms and conditions may be changed or modified by us without any prior notice.",
                style: paragraphStyle),
            Text(
                "All the content offered on our site is copyrighted content of their respective owners; a user must not copy, distribute or modify any of the content provided on APKdojo.",
                style: paragraphStyle),
            Text(
                "All the content provided on our website is collected from various sources over the internet; we shall not be responsible for any kind of loss or harm that may occur by using the services. The user will be solely and only responsible for any such event.",
                style: paragraphStyle),
            Text(
                "The user must agree to use APKdojo for personal use only, and hence no commercial use of the website or any content hosted will be tolerated.",
                style: paragraphStyle),
            Text(
                "The user must follow their respective country's laws while using APKdojo; we are not liable for any unlawful use of the content hosted on the website.",
                style: paragraphStyle),
            Text(
                "The user must not use the website to threaten, harras or abuse any person, user, or the admins of APKdojo. We may take legal action against those violating our terms and conditions."),
            Text("PRIVACY POLICY", style: headingStyles),
            Text(
                "At APKdojo, we consider privacy policy as our utmost concern, so that is why we would like to elaborate on what and why we collect these data.",
                style: paragraphStyle),
            Text("What Personal Data do we intend to collect and Why?",
                style: paragraphStyle),
            Text("User's Comments", style: headingStyles),
            Text(
                "When user comments or rates any apps we collect the data they had commented or rated. We also collect the email, name, and IP address of the respective user. This data is only collected to make comments spam-free. We do not wish or intend to use this data for any commercial purpose.",
                style: paragraphStyle),
            Text("Log Files", style: headingStyles),
            Text(
                "Like any other website, we collect users' log files. Log files consist of the user's IP address, Internet service provider, browser, and device information. We also keep track of user time spent on the website along with the pages they had visited. For this, we use the Google Analytics service.",
                style: paragraphStyle),
            Text("Cookies", style: headingStyles),
            Text(
                "Cookies serve as an integral part of delivering users a better web experience. To understand Cookies better, these are actually small text files that are sent to APKdojo by the user's browser. These files are not meant to harm the user in any way as they don't contain any private information. The sole purpose of cookies is to provide you with a better browsing experience as well as relevant ad delivery.",
                style: paragraphStyle),
            Text("Contact Information", style: headingStyles),
          ],
        ),
      ),
    );
  }
}
