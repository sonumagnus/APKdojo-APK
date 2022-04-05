import 'package:flutter/material.dart';

ExpansionPanel apkDetailsExpansionPanel(
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot, List<bool> _isOpen) {
  return ExpansionPanel(
      headerBuilder: (BuildContext context, isOpen) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: const Text(
            "APK Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
      body: Column(
        children: [
          ListTile(
            leading: const Text("Name"),
            trailing: Text(snapshot.data!['name']),
          ),
          ListTile(
            leading: const Text("Developer"),
            trailing: Text(snapshot.data!['developer']),
          ),
          ListTile(
            leading: const Text("Package"),
            trailing: Text(snapshot.data!['app_package']),
          ),
          ListTile(
            leading: const Text("Version"),
            trailing: Text(snapshot.data!['version']),
          ),
          ListTile(
            leading: const Text("Size"),
            trailing: Text(snapshot.data!['size']),
          ),
          ListTile(
            leading: const Text("Requires"),
            trailing: Text(snapshot.data!['minsdk']),
          ),
          ListTile(
            leading: const Text("Category"),
            trailing: Text(snapshot.data!['category']),
          ),
          ListTile(
            leading: const Text("Updated"),
            trailing: Text(snapshot.data!['updated']),
          ),
          ListTile(
            leading: const Text("Added"),
            trailing: Text(snapshot.data!['added']),
          ),
          const ListTile(
            leading: Text("License"),
            trailing: Text("Free"),
          ),
        ],
      ),
      isExpanded: _isOpen[1]);
}
