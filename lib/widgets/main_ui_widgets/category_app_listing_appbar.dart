import 'package:flutter/material.dart';

class CategoryAppListingHeader extends StatefulWidget {
  final String applicationType;
  final AsyncSnapshot<List> categoryList;
  const CategoryAppListingHeader({
    Key? key,
    required this.applicationType,
    required this.categoryList,
  }) : super(key: key);

  @override
  State<CategoryAppListingHeader> createState() => _CategoryAppListingHeaderState();
}

class _CategoryAppListingHeaderState extends State<CategoryAppListingHeader> {
  @override
  Widget build(BuildContext context) {
    var _tabNameStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.visible,
    );
    return DefaultTabController(
      length: widget.categoryList.data!.length,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 6,
        ),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
          child: TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.grey.shade800,
            unselectedLabelColor: Colors.grey.shade700,
            indicatorColor: Colors.green.shade500,
            tabs: [
              for (int i = 0; i < widget.categoryList.data!.length; i++)
                Tab(
                  child: Text(
                    widget.categoryList.data![i]['catname'],
                    style: _tabNameStyle,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
