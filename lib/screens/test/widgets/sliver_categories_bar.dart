import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

import '../controller/controllers.dart';
import '../data/categories.dart';
import 'icon_category.dart';

class SliverCategoriesBar extends StatelessWidget {
  const SliverCategoriesBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverPadding(
      sliver: SliverPersistentHeader(
        delegate: _HeaderSliver(
          size: size,
          controller: sliverScrollController,
        ),
        pinned: true,
      ),
      padding: const EdgeInsets.only(
        bottom: kDefaultPadding,
      ),
    );
  }
}

class _HeaderSliver extends SliverPersistentHeaderDelegate {
  final SliverScrollController controller;
  final Size size;

  _HeaderSliver({required this.controller, required this.size});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool visible = shrinkOffset > 0;
    if (visible) {
      controller.visibleHeader.value = true;
    } else {
      controller.visibleHeader.value = false;
    }
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i in categories) ...[
                  IconCategory(
                    title: i['title']!,
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get minExtent => 146;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 146;
}

