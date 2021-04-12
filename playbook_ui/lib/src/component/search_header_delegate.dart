import 'package:flutter/material.dart';

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  const SearchHeaderDelegate({required this.controller});

  final TextEditingController controller;

  @override
  double get minExtent => 1;

  @override
  double get maxExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: LayoutBuilder(builder: (context, constrain) {
        return Stack(
          children: <Widget>[
            Positioned(
              width: constrain.maxWidth,
              bottom: 4,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              width: constrain.maxWidth,
              left: 0,
              bottom: 0,
              child: const Divider(height: 1),
            ),
          ],
        );
      }),
    );
  }
}
