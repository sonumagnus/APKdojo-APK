import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/screens/download.dart';
import 'package:flutter/material.dart';

class SlugIconNameDownloadButton extends StatelessWidget {
  final String icon;
  final String developerUrl;
  final String developer;
  final String name;
  final String seourl;
  const SlugIconNameDownloadButton(
      {Key? key,
      required this.icon,
      required this.developer,
      required this.developerUrl,
      required this.name,
      required this.seourl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              icon,
              width: 80,
              height: 80,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DevProfileAndApps(
                        devURL: developerUrl,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Text(
                      "• ",
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                    Text(
                      developer,
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Download(seourl: seourl),
                        ),
                      );
                    },
                    child: const Text("Download"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green.shade100),
                      color: Colors.grey.shade100,
                    ),
                    child: const Icon(
                      Icons.share,
                      size: 18,
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
