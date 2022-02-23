import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 17);
    const size = 30.0;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            child: Text(
              "APKdojo",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            decoration: BoxDecoration(color: Colors.cyan),
          ),
          ListTile(
            leading: Icon(Icons.home, size: size),
            title: Text("Home", style: textStyle),
          ),
          ListTile(
            leading: Icon(Icons.apps, size: size),
            title: Text("Apps", style: textStyle),
          ),
          ListTile(
            leading: Icon(Icons.games, size: size),
            title: Text("Games", style: textStyle),
          ),
          ListTile(
            leading: Icon(Icons.developer_board, size: size),
            title: Text("Developers", style: textStyle),
          ),
          ListTile(
            leading: Icon(Icons.star, size: size),
            title: Text("Editor's Choice", style: textStyle),
          ),
          ListTile(
            leading: Icon(Icons.verified_user, size: size),
            title: Text("About", style: textStyle),
          ),
          ListTile(
            leading: Icon(Icons.control_point_duplicate_outlined, size: size),
            title: Text("Terms of Use", style: textStyle),
          ),
        ],
      ),
    );
  }
}
