import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SlugDescription extends StatefulWidget {
  final String description;
  const SlugDescription({Key? key, required this.description})
      : super(key: key);

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
        ConstrainedBox(
          constraints: isExpanded
              ? const BoxConstraints()
              : const BoxConstraints(maxHeight: 80),
          child: Html(
            data: widget.description,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Chip(
            label: Text(
              isExpanded ? "Show Less" : "Show More",
              style: const TextStyle(fontSize: 12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: -2),
          ),
        ),

        // Html(data: widget.description),
      ],
    );
  }
}
