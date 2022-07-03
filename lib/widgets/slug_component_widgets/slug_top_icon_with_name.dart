import 'package:apkdojo/providers/downloading_progress.dart';
import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/slug_component_widgets/download_button_with_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SlugTopIconWithName extends StatelessWidget {
  final String? icon, name, developer, developerUrl, seourl, apkurl, playStoreUrl, version, packageName, size;

  const SlugTopIconWithName({
    Key? key,
    required this.icon,
    required this.name,
    required this.developer,
    required this.developerUrl,
    required this.seourl,
    required this.apkurl,
    required this.playStoreUrl,
    required this.version,
    required this.packageName,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      Consumer<SingleAPkState>(builder: (context, value, child) {
        bool _downloadingRunning = value.downloadTaskStatus == DownloadTaskStatus.running && value.appName == name;
        return Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: _downloadingRunning ? const EdgeInsets.all(22) : const EdgeInsets.all(0),
              width: 75,
              height: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    "assets/images/lazy_images/lazy-image.jpg",
                  ),
                  fit: BoxFit.fill,
                  imageUrl: icon!,
                ),
              ),
            ),
            if (value.progress == 0 && _downloadingRunning)
              const SizedBox(
                width: 65,
                height: 65,
                child: CircularProgressIndicator(
                  strokeWidth: 1.8,
                  color: Colors.green,
                ),
              ),
            if (_downloadingRunning)
              SizedBox(
                width: 65,
                height: 65,
                child: CircularProgressIndicator(
                  value: double.parse("${value.progress}") / 100,
                  strokeWidth: 1.8,
                  color: Colors.green,
                ),
              ),
          ],
        ).pOnly(right: 25, top: 12);
      }),
      [
        Html(
          data: name,
          style: {
            "*": Style(
              margin: EdgeInsets.zero,
              fontSize: const FontSize(22),
              color: Theme.of(context).textTheme.titleMedium!.color,
              fontWeight: FontWeight.w600,
            ),
          },
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DevProfileAndApps(devURL: developerUrl!),
            ),
          ),
          child: [
            "• ".text.size(20).color(Colors.red.shade200).make(),
            Html(
              data: developer,
              style: {
                "*": Style(
                  fontSize: const FontSize(15),
                  margin: EdgeInsets.zero,
                  color: Colors.green.shade500,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              },
            ).expand(),
          ].hStack(),
        ),
        [
          DownloadButtonWithLogic(
            name: name!,
            apkurl: apkurl!,
            version: version!,
            playStoreUrl: playStoreUrl!,
            packageName: packageName!,
            size: size!,
          ).pOnly(top: 5),
        ].hStack(
          alignment: MainAxisAlignment.spaceBetween,
          crossAlignment: CrossAxisAlignment.end,
          axisSize: MainAxisSize.max,
        ),
      ].vStack(crossAlignment: CrossAxisAlignment.start).expand()
    ].hStack(crossAlignment: CrossAxisAlignment.start).pLTRB(p20, 12, p20, 10);
  }
}
