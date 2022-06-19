import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ConstrainedBox(
            constraints: isExpanded ? const BoxConstraints() : const BoxConstraints(maxHeight: 80),
            child: Html(
              data: widget.description,
              style: {
                "*": Style(
                  fontSize: const FontSize(12),
                  color: Theme.of(context).textTheme.titleSmall!.color,
                ),
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 1),
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.displayMedium!.color,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    isExpanded ? "Less" : "More",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
