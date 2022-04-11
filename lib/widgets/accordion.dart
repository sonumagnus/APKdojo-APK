import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final String title;
  final Widget contentWidget;

  const Accordion({
    Key? key,
    required this.title,
    required this.contentWidget,
  }) : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showContent = !_showContent;
            });
          },
          child: ListTile(
            contentPadding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            visualDensity: VisualDensity.compact,
            dense: true,
            title: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ),
        ),
        _showContent
            ? Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: widget.contentWidget,
              )
            : Container(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(height: 0),
        )
      ],
    );
  }
}
