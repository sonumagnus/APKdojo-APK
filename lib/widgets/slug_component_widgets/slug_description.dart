import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:velocity_x/velocity_x.dart';

class SlugDescription extends StatefulWidget {
  final String description;
  const SlugDescription({Key? key, required this.description}) : super(key: key);

  @override
  State<SlugDescription> createState() => _SlugDescriptionState();
}

class _SlugDescriptionState extends State<SlugDescription> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ConstrainedBox(
              constraints: isExpanded ? const BoxConstraints() : const BoxConstraints(maxHeight: 102),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Description".text.size(16).semiBold.color(Theme.of(context).textTheme.titleMedium!.color).make().pOnly(left: 8),
                    Html(
                      data: widget.description,
                      style: {
                        "*": Style(
                          fontSize: const FontSize(15),
                          color: Theme.of(context).textTheme.titleSmall!.color,
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                isExpanded ? "Less" : "More",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade600,
                ),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.green.shade500,
              ),
            ],
          ),
        ).pSymmetric(v: 4),
        const Divider().pSymmetric(h: 10)
      ],
    ).pOnly(left: 12, right: 12, top: 4);
  }
}
