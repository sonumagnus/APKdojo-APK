import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

checkPermission() async {
  PermissionStatus permissionStatus = await Permission.storage.request();
  if (permissionStatus.isGranted) {
    return;
  } else if (permissionStatus.isDenied) {
    SystemNavigator.pop();
  } else if (permissionStatus.isPermanentlyDenied) {
    openAppSettings();
  }
}
