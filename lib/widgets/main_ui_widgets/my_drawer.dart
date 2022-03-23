import 'package:apkdojo/home.dart';
import 'package:apkdojo/widgets/new_added_n_updated_apps.dart';
import 'package:flutter/material.dart';
import 'package:apkdojo/screens/about.dart';
import 'package:apkdojo/screens/developers.dart';
import 'package:apkdojo/screens/terms_of_use.dart';
import 'package:apkdojo/widgets/categorytabs.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 17);
    const size = 30.0;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              "APKdojo",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            decoration: BoxDecoration(color: Colors.cyan),
          ),
          ListTile(
            leading: const Icon(Icons.home, size: size),
            title: const Text("Home", style: textStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.apps, size: size),
            title: const Text("Apps", style: textStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryByTabs(
                    selectedIndex: 0,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.games, size: size),
            title: const Text("Games", style: textStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryByTabs(selectedIndex: 1),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.developer_board, size: size),
            title: const Text("Developers", style: textStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Developers(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, size: size),
            title: const Text("Editor's Choice", style: textStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewAddedAndUpdatedApps(
                      applicationType: "featured_apps"),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user, size: size),
            title: const Text("About", style: textStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const About(),
                ),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.control_point_duplicate_outlined, size: size),
            title: const Text("Terms of Use", style: textStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsOfUse(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
