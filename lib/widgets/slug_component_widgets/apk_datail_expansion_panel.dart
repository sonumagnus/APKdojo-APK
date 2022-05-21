import 'package:apkdojo/widgets/accordion.dart';
import 'package:flutter/material.dart';

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
          leading: Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          trailing: Text(
            value,
            style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
          ),
        ),
        const Divider(height: 4)
      ],
    );
  }
}
