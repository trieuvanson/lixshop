import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lixshop/repositories/slide/slide_repository.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/models.dart';
import '../../../models/productlist.dart';
import '../../../utils/design_course_app_theme.dart';
import 'slide_item.dart';
import '../constants/constants.dart';

class SliverHeaderBanner extends StatefulWidget {
  const SliverHeaderBanner({Key? key}) : super(key: key);

  @override
  State<SliverHeaderBanner> createState() => _SliverHeaderBannerState();
}

class _SliverHeaderBannerState extends State<SliverHeaderBanner> {
  final CarouselController _controller = CarouselController();
  List<Slide> _slides = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    getSlides();
    super.initState();
  }

  List<Widget> slides(BuildContext context) {
    return _slides
        .map((slide) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                constraints: const BoxConstraints(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SlideItem(
                  img: slide.imageUrl!,
                  title: slide.title!,
                  address: slide.content!,
                  rating: slide.type!,
                ),
              ),
            ),
          );
        })
        .toList();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  getSlides() async {
    final slides = await slideRepository.getSlides();
    _slides = slides!;
    _isLoading = false;
    setState(() {});
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _isLoading || _slides.isEmpty
        ? const SliverToBoxAdapter(child: SizedBox.shrink())
        : SliverPadding(
            padding: const EdgeInsets.only(top: kDefaultPadding),
            sliver: SliverToBoxAdapter(
              child: Container(
                color: DesignCourseAppTheme.notWhite,
                child: Column(
                  children: <Widget>[
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        height: 210,
                        autoPlay: true,
                        scrollDirection: Axis.horizontal,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: _slides
                          .map((slide) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              constraints: const BoxConstraints(),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: SlideItem(
                                img: slide.imageUrl!,
                                title: slide.title!,
                                address: slide.content!,
                                rating: slide.type!,
                              ),
                            ),
                          ),
                        );
                      })
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: map<Widget>(
                          _slides,
                          (index, url) {
                            return InkWell(
                              onTap: () => _controller.animateToPage(index),
                              child: Container(
                                width: _currentIndex == index ? 40.0 : 15.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? Vx.green700
                                      : Colors.grey,
                                  shape: _currentIndex == index
                                      ? BoxShape.rectangle
                                      : BoxShape.circle,
                                  borderRadius: _currentIndex == index
                                      ? const BorderRadius.all(
                                          Radius.circular(8.0))
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
