import 'package:apkdojo/widgets/main_ui_widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          TermsOfUseHeadings(
            heading: "/ Terms of Use",
            fontSize: 22,
          ),
          TermsOfUseTextContent(
              textContent:
                  "At APKdojo, We solely intend to provide you with free android APK's for mobile apps and to use our free service; we require our users to abide by a few terms and conditions listed below. Please do note that these terms and conditions may be changed or modified by us without any prior notice.\nAll the content offered on our site is copyrighted content of their respective owners; a user must not copy, distribute or modify any of the content provided on APKdojo.\nAll the content provided on our website is collected from various sources over the internet; we shall not be responsible for any kind of loss or harm that may occur by using the services. The user will be solely and only responsible for any such event.\nThe user must agree to use APKdojo for personal use only, and hence no commercial use of the website or any content hosted will be tolerated.\nThe user must follow their respective country's laws while using APKdojo; we are not liable for any unlawful use of the content hosted on the website.\nThe user must not use the website to threaten, harras or abuse any person, user, or the admins of APKdojo. We may take legal action against those violating our terms and conditions."),
          TermsOfUseHeadings(heading: "PRIVACY POLICY"),
          TermsOfUseTextContent(
            textContent: "At APKdojo, we consider privacy policy as our utmost concern, so that is why we would like to elaborate on what and why we collect these data.",
          ),
          TermsOfUseTextContent(
            textContent: "What Personal Data do we intend to collect and Why?",
          ),
          TermsOfUseHeadings(heading: "User's Comments"),
          TermsOfUseTextContent(
            textContent:
                "When user comments or rates any apps we collect the data they had commented or rated. We also collect the email, name, and IP address of the respective user. This data is only collected to make comments spam-free. We do not wish or intend to use this data for any commercial purpose.",
          ),
          TermsOfUseHeadings(heading: "Log Files"),
          TermsOfUseTextContent(
            textContent:
                "Like any other website, we collect users' log files. Log files consist of the user's IP address, Internet service provider, browser, and device information. We also keep track of user time spent on the website along with the pages they had visited. For this, we use the Google Analytics service.",
          ),
          TermsOfUseHeadings(heading: "Cookies"),
          TermsOfUseTextContent(
            textContent:
                "Cookies serve as an integral part of delivering users a better web experience. To understand Cookies better, these are actually small text files that are sent to APKdojo by the user's browser. These files are not meant to harm the user in any way as they don't contain any private information. The sole purpose of cookies is to provide you with a better browsing experience as well as relevant ad delivery.",
          ),
          TermsOfUseHeadings(heading: "Contact Information"),
          TermsOfUseTextContent(
            textContent:
                "Whenever a user contacts us via contact forms, we do collect their names, emails, and message. This information is not shared with anyone or published anywhere and is solely retain to reply to the user. So feel free to contact us via the contact form, or you can directly contact us at support@apkdojo.com. If you are not comfortable with any terms or privacy policy, then you shall leave the website immediately.",
          )
        ],
      ),
    );
  }
}

class TermsOfUseTextContent extends StatelessWidget {
  final String textContent;
  const TermsOfUseTextContent({
    Key? key,
    required this.textContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Text(
        textContent,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}

class TermsOfUseHeadings extends StatelessWidget {
  final String heading;
  final double fontSize;
  const TermsOfUseHeadings({
    Key? key,
    this.fontSize = 17,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        heading,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
