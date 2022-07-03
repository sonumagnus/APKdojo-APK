import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:velocity_x/velocity_x.dart';

class DeviceInstalledApps extends HookWidget {
  const DeviceInstalledApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Application>> getInstalledApps() async {
      List<Application> apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: false,
      );
      return apps;
    }

    return Scaffold(
      body: FutureBuilder<List<Application>>(
        future: getInstalledApps(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Application app = snapshot.data![index];
                return Column(
                  children: [
                    ListTile(
                      leading: app is ApplicationWithIcon ? Image.memory(app.icon, height: 60, width: 60) : null,
                      title: Text(app.appName),
                      subtitle: app.packageName.text.color(Theme.of(context).textTheme.titleSmall!.color).make(),
                      trailing: PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            onTap: () => DeviceApps.uninstallApp(app.packageName),
                            child: const Text("Uninstall"),
                          ),
                          PopupMenuItem(
                            onTap: () => DeviceApps.openApp(app.packageName),
                            child: const Text("Open"),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 2).pOnly(left: 85, right: 30),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return "Error".text.makeCentered();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
