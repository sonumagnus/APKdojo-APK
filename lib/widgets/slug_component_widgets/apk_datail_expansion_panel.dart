import 'package:apkdojo/widgets/accordion.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ApkDetailsExpansionPanel extends StatelessWidget {
  final Map<dynamic, dynamic>? appData;
  const ApkDetailsExpansionPanel({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Accordion(
      title: "APK Details",
      contentWidget: Column(
        children: [
          ApkDetailsSingleKeyValue(
            title: "name",
            value: appData!["name"],
          ),
          ApkDetailsSingleKeyValue(
            title: "Developer",
            value: appData!["developer"],
          ),
          ApkDetailsSingleKeyValue(
            title: "Package",
            value: appData!["app_package"],
          ),
          ApkDetailsSingleKeyValue(
            title: "Version",
            value: appData!["version"],
          ),
          ApkDetailsSingleKeyValue(
            title: "Size",
            value: appData!["size"],
          ),
          ApkDetailsSingleKeyValue(
            title: "Requires",
            value: appData!["minsdk"],
          ),
          ApkDetailsSingleKeyValue(
            title: "Category",
            value: appData!["category"],
          ),
          ApkDetailsSingleKeyValue(
            title: "Updated",
            value: appData!["updated"],
          ),
          ApkDetailsSingleKeyValue(
            title: "Added",
            value: appData!["added"],
          ),
          const ApkDetailsSingleKeyValue(
            title: "License",
            value: "Free",
          ),
        ],
      ),
    );
  }
}

class ApkDetailsSingleKeyValue extends StatelessWidget {
  final String title;
  final String value;
  const ApkDetailsSingleKeyValue({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          dense: true,
          leading: title.text.color(Theme.of(context).textTheme.titleMedium!.color).size(16).make(),
          trailing: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).textTheme.titleSmall!.color,
            ),
          ).box.width(context.mq.size.width * 3 / 5).alignCenterRight.make(),
        ),
        const Divider(height: 4)
      ],
    );
  }
}
