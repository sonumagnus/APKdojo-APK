import 'dart:io';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/app_methods.dart';

class AllApksInInternalStorage extends StatefulWidget {
  const AllApksInInternalStorage({Key? key}) : super(key: key);

  @override
  State<AllApksInInternalStorage> createState() => _AllApksInInternalStorageState();
}

class _AllApksInInternalStorageState extends State<AllApksInInternalStorage> {
  late List<FileSystemEntity> _apkFiles;

  Future<void> getApplicationList() async {
    _apkFiles = await App.getListOfApplicationsFromDirectory(
      getApksFromAllDirectories: true,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _apkFiles = [];
    getApplicationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _apkFiles.isEmpty
          ? "No Downloads".text.size(25).medium.gray400.makeCentered()
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _apkFiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              child: Image.asset(
                                'assets/images/lazy_images/lazy-image.jpg',
                              ),
                            ),
                            title: "${App.apkName(apkPath: _apkFiles[index].path)}".text.color(Theme.of(context).textTheme.titleMedium!.color).medium.make(),
                          ),
                          const Divider(height: 8).pOnly(left: 80, right: 40)
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
