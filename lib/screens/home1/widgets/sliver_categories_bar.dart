import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lixshop/screens/home1/widgets/category_items_loader.dart';

import '../../../core/core.dart';
import '../constants.dart';
import 'icon_category.dart';

class SliverCategoriesBar extends StatelessWidget {
  const SliverCategoriesBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return SliverPadding(
      sliver: SliverPersistentHeader(
        delegate: _HeaderSliver(
          padding: padding,
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
  final EdgeInsets padding;
  _HeaderSliver({required this.padding});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool visible = shrinkOffset > 0;
    return BlocBuilder<ResultOutsideCubit, ResultOutsideState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CategoryItemsLoader(
            type: CategoryLoaderType.loading,
          );
        } else if (state.isError) {
          return const CategoryItemsLoader(
            type: CategoryLoaderType.error,
          );
        } else if (state.isSuccess) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: padding.top),
                color: kBackgroundColor,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var item in state
                          .resultDataModel!.productOutsideCategory!) ...[
                        IconCategory(
                          title: item.cateName!,
                          imageUrl: item.catePath!,
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  @override
  double get minExtent => 146 + padding.top;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 146 + padding.top;
}
