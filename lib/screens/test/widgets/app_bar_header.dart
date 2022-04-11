import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../controller/controllers.dart';

class AppBarHeaderSliver extends StatelessWidget {
  final double valueCurrentScroll;

  const AppBarHeaderSliver({Key? key, required this.valueCurrentScroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      expandedHeight: appBarHeaderController.pinnedAppBar(valueCurrentScroll)
          ? size.height * 0.1
          : size.height * 0.25 - 27,
      stretch: true,
      pinned: appBarHeaderController.pinnedAppBar(valueCurrentScroll),
      collapsedHeight: appBarHeaderController.pinnedAppBar(valueCurrentScroll)
          ? size.height * 0.1
          : size.height * 0.25 - 27,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: const [StretchMode.zoomBackground],
        background: appBarHeaderController.pinnedAppBar(valueCurrentScroll)
            ? Container(
                padding: EdgeInsets.only(top: padding.top),
                child: Stack(
                  children: const [
                    _SearchBar(),
                  ],
                ),
              )
            : Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      top: kDefaultPadding / 2,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding + 36,
                    ),
                    height: size.height * 0.3 - 27,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                  ),
                  Positioned(
                    top: appBarHeaderController.getPositionHeight(
                        valueCurrentScroll, padding.top),
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Xin chào, Sơn",
                            style:
                                Theme.of(context).textTheme.headline5?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          InkWell(
                            onTap: () {
                              print('click');
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.8,
                                  child: Text(
                                    "Giao tới: 87 Đường số 6, Phường 10, Gò Vấp, Hồ Chí Minh",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                const Spacer(),
                                //dropdown icon
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const _SearchBar(),
                  // Positioned(
                  //     left: 10,
                  //     top: padding.top,
                  //     child: IconButton(
                  //       icon: SvgPicture.asset("assets/icons/menu.svg"),
                  //       onPressed: () {
                  //         Get.to(() => const DetailScreen());
                  //       },
                  //     )),
                ],
              ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 20,
      right: 0,
      left: 0,
      child: InkWell(
        onTap: () {
        },
        child: Container(
          width: size.width,
          height: size.height * 0.07,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(size.width * 0.08),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                )
              ]),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {},
                  onTap: () {
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              SvgPicture.asset('assets/icons/search.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
