import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildSheet() => Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Share on",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgIconWithName(
                iconName: "Facebook",
                iconSvgName: "facebook",
                iconColor: Colors.indigo.shade500,
              ),
              SvgIconWithName(
                iconName: "Twitter",
                iconSvgName: "twitter",
                iconColor: Colors.blue.shade500,
              ),
              SvgIconWithName(
                iconName: "Reddit",
                iconSvgName: "reddit",
                iconColor: Colors.red.shade400,
              ),
              SvgIconWithName(
                iconName: "Whatsapp",
                iconSvgName: "whatsapp",
                iconColor: Colors.lightGreen.shade600,
              ),
              SvgIconWithName(
                iconName: "Vekontakte",
                iconSvgName: "vk",
                iconColor: Colors.purple.shade600,
              ),
            ],
          )
        ],
      ),
    );

class SvgIconWithName extends StatelessWidget {
  final String iconName;
  final String iconSvgName;
  final Color iconColor;
  const SvgIconWithName({
    Key? key,
    required this.iconName,
    required this.iconSvgName,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/images/category_icons/ui-$iconSvgName.svg",
          height: 50.0,
          width: 50.0,
          color: iconColor,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          iconName,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
