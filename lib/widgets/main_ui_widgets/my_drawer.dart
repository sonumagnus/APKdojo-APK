import 'package:apkdojo/home.dart';
import 'package:apkdojo/widgets/new_added_n_updated_apps.dart';
import 'package:flutter/material.dart';
import 'package:apkdojo/screens/about.dart';
import 'package:apkdojo/screens/developers.dart';
import 'package:apkdojo/screens/terms_of_use.dart';
import 'package:apkdojo/widgets/categorytabs.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
    );
    const _size = 25.0;
    Color _iconColor = Colors.grey.shade700;

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 34,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 80,
                  right: 80,
                ),
                child: SvgPicture.asset(
                  'assets/images/apkdojoNameIcon.svg',
                  semanticsLabel: "Apkdojo svg icon",
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: _size,
                color: _iconColor,
              ),
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
              leading: SvgPicture.asset(
                "assets/images/drawer_icons/app_store_ios.svg",
                height: 23,
                width: 23,
                color: Colors.grey.shade700,
              ),
              title: const Text("Apps", style: textStyle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryByTabs(
                      selectedIndex: 0,
                      mediaQueryHeightDivider: 4.7,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.sports_esports,
                size: _size,
                color: _iconColor,
              ),
              title: const Text("Games", style: textStyle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryByTabs(
                      selectedIndex: 1,
                      mediaQueryHeightDivider: 4.7,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.developer_mode,
                size: _size,
                color: _iconColor,
              ),
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
              leading: Icon(
                Icons.star,
                size: _size,
                color: _iconColor,
              ),
              title: const Text("Editor's Choice", style: textStyle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewAddedAndUpdatedApps(
                      applicationType: "featured_apps",
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.verified_user,
                size: _size,
                color: _iconColor,
              ),
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
              leading: Icon(
                Icons.assignment,
                size: _size,
                color: _iconColor,
              ),
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
      ),
    );
  }
}
