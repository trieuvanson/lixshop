import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';
import '../constants/constants.dart';
import 'category_items_loader.dart';
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
    return FutureBuilder(
      future: resultDataOutsideRepository.getResultData(),
      builder: (context, AsyncSnapshot<ResultDataModel> snapshot) {
        ResultDataModel? resultDataModel = snapshot.data;
        return snapshot.hasData
              ? resultDataModel!.productOutsideCategory!.isNotEmpty
                ? Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: padding.top),
                        color: kBackgroundColor,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var item in resultDataModel
                                  .productOutsideCategory!) ...[
                                IconCategory(item: item),
                              ]
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const CategoryItemsLoader(
                    type: CategoryLoaderType.error,
                  )
            : const CategoryItemsLoader(
                type: CategoryLoaderType.loading,
              );
      },
    );
    // return BlocConsumer<ResultOutsideCubit, ResultOutsideState>(
    //   listener: (context, state) {
    //     if (state.isError) {
    //       showSnackBar("Lỗi hệ thống, vui lòng thử lại sau!", context,
    //           duration: 3000);
    //     }
    //   },
    //   listenWhen: (previous, current) => previous != current,
    //   buildWhen: (previous, current) => previous != current,
    //   builder: (context, state) {
    //     if (state.isLoading) {
    //       return const CategoryItemsLoader(
    //         type: CategoryLoaderType.loading,
    //       );
    //     } else if (state.isError) {
    //       return const CategoryItemsLoader(
    //         type: CategoryLoaderType.error,
    //       );
    //     } else if (state.isSuccess) {
    //       return Stack(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.only(top: padding.top),
    //             color: kBackgroundColor,
    //             width: double.infinity,
    //             child: SingleChildScrollView(
    //               scrollDirection: Axis.horizontal,
    //               child: Row(
    //                 children: [
    //                   for (var item in state
    //                       .resultDataModel!.productOutsideCategory!) ...[
    //                     IconCategory(item: item),
    //                   ]
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //
    //     return Container();
    //   },
    // );
  }

  @override
  double get minExtent => 224;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => 224;
}
