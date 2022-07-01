import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lixshop/main_screen.dart';
import 'package:lixshop/screens/screen.dart';

import '../../../repositories/repositories.dart';
import '../../../utils/helpers/secure_storage.dart';
import '../constants/constants.dart';

class AppBarHeaderSliver extends StatefulWidget {
  const AppBarHeaderSliver({Key? key}) : super(key: key);

  @override
  State<AppBarHeaderSliver> createState() => _AppBarHeaderSliverState();
}

class _AppBarHeaderSliverState extends State<AppBarHeaderSliver> {
  String address = '...';
  String name = 'Khách';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final currentUser = await secureStorage.getCurrentUser();
    if (currentUser != null) {
      if (!mounted) return;

      setState(() {
        address = currentUser.address ?? '';
        name = currentUser.name ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      expandedHeight: 125,
      collapsedHeight: 125,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
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
              top: padding.top,
              left: kDefaultPadding,
              right: kDefaultPadding,
              child: InkWell(
                onTap: () {
                  Get.to(() => const ProfileInformationScreen());
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Xin chào, $name",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            "Giao tới: $address",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                          )
                          // const Icon(
                          //   Icons.arrow_drop_down,
                          //   color: Colors.white,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const _SearchBar(bottom: 20),
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
  final double bottom;

  const _SearchBar({Key? key, required this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: bottom,
      right: 0,
      left: 0,
      child: InkWell(
        onTap: () {
          Get.off(() => const SearchScreen());
        },
        child: Container(
          width: size.width,
          height: 50,
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
                    Get.to(() => const SearchScreen());
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm',
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
