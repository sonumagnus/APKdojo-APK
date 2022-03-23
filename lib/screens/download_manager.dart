import 'dart:io';
import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class DownloadManager extends StatefulWidget {
  const DownloadManager({Key? key}) : super(key: key);

  @override
  State<DownloadManager> createState() => _DownloadManagerState();
}

class _DownloadManagerState extends State<DownloadManager> {
  late List<FileSystemEntity> _allFiles;
  late List<FileSystemEntity> _apkFiles;

  Future<void> getDir() async {
    Directory? directory = await getExternalStorageDirectory();
    String _newPath = "";

    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        _newPath += "/" + folder;
      } else {
        break;
      }
    }
    _newPath = _newPath + "/APKdojo";
    directory = Directory(_newPath);

    final dir = directory.path;
    String apkDirectory = '$dir/';
    final myDir = Directory(apkDirectory);
    _allFiles = myDir.listSync(recursive: true, followLinks: true);
    setState(() {
      _apkFiles =
          _allFiles.where((element) => element.path.endsWith('.apk')).toList();
    });
  }

  _fileName(String filePath) {
    final _splitedList = filePath.split("/");
    final _apkNameWithExtension = _splitedList[_splitedList.length - 1];
    final _apkNameWithoutExtension =
        _apkNameWithExtension.replaceAll(".apk", "");
    return _apkNameWithoutExtension;
  }

  Future<void> _deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        setState(() {
          getDir();
        });
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  Future<void> _deleteConfirmationAlertBox(String file) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do You Really Want to Delete ${_fileName(file)} ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                _deleteFile(File(file));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _apkFiles = [];
    getDir();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          context.read<DownloadingProgress>().progress == 0 && _apkFiles.isEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
      children: [
        Consumer<DownloadingProgress>(
          builder: (context, provider, child) {
            return provider.progress > 0
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 65,
                        child: Card(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: LinearProgressIndicator(
                              value: provider.progress.toDouble() / 100,
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green.shade300),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "${provider.progress < 100 ? "Downloading" : "Downloaded"} : ${provider.appName} (${provider.progress}%)",
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade700),
                      )
                    ],
                  )
                : const SizedBox();
          },
        ),
        _apkFiles.isEmpty
            ? Center(
                child: Text(
                  "No Downloads",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _apkFiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 1,
                    child: GestureDetector(
                      onTap: () {
                        OpenFile.open(_apkFiles[index].path);
                      },
                      child: ListTile(
                        title: Text(
                          _fileName(
                            _apkFiles[index].path,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () => _deleteConfirmationAlertBox(
                              _apkFiles[index].path),
                          child: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
