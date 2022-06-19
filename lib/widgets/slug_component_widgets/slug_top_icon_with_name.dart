import 'package:apkdojo/screens/devprofile.dart';
import 'package:apkdojo/styling_refrence/style.dart';
import 'package:apkdojo/widgets/slug_component_widgets/download_button_with_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class SlugTopIconWithName extends StatelessWidget {
  final String? icon, name, developer, developerUrl, seourl, apkurl, playStoreUrl, version;

  const SlugTopIconWithName({Key? key, this.icon, this.name, this.developer, this.developerUrl, this.seourl, this.apkurl, this.playStoreUrl, this.version}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          placeholder: (context, url) => Image.asset(
            "assets/images/lazy_images/lazy-image.jpg",
          ),
          imageUrl: icon!,
          width: 90,
          height: 90,
        ),
      ).pOnly(right: 20),
      [
        name!.text.size(18).semiBold.make(),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DevProfileAndApps(devURL: developerUrl!),
            ),
          ),
          child: [
            "• ".text.size(18).green500.make(),
            Html(
              data: developer,
              style: {
                "*": Style(
                  margin: EdgeInsets.zero,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              },
            ).expand(),
          ].hStack().pSymmetric(v: 2),
        ),
        [
          DownloadButtonWithLogic(
            name: name!,
            apkurl: apkurl!,
            version: version!,
            playStoreUrl: playStoreUrl!,
          ),
          GestureDetector(
            onTap: () => Share.share("https://www.apkdojo.com/$seourl"),
            child: VxBox(
              child: Icon(Icons.share, size: 18, color: Colors.green.shade400),
            ).square(35).border(width: 1, color: Vx.gray300).color(Theme.of(context).scaffoldBackgroundColor).roundedFull.make(),
          ),
        ].hStack(
          alignment: MainAxisAlignment.spaceBetween,
          crossAlignment: CrossAxisAlignment.end,
          axisSize: MainAxisSize.max,
        ),
      ].vStack(crossAlignment: CrossAxisAlignment.start).expand()
    ].hStack(crossAlignment: CrossAxisAlignment.start).pLTRB(p20, p20, p20, 10);
  }
}
