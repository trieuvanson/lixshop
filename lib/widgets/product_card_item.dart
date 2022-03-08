import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lixshop/screens/course_info_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../screens/product_detail.dart';
import '../utils/const.dart';
import '../utils/design_course_app_theme.dart';

class ProductCardItem extends StatefulWidget {
  final String img;
  final String title;
  final String address;
  final String rating;

  const ProductCardItem({
    Key? key,
    required this.img,
    required this.title,
    required this.address,
    required this.rating,
  }) : super(key: key);

  @override
  _ProductCardItemState createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => CourseInfoScreen(),
          routeName: '/product-detail1/${widget.title}',
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          width: MediaQuery.of(context).size.width / 2,
          height: 350,
          decoration: BoxDecoration(
            color: DesignCourseAppTheme.nearlyWhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: DesignCourseAppTheme.nearlyBlack.withOpacity(1),)
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    widget.img,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 4, right: 8),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 8),
                    child: Text(
                      'VNĐ 12.345',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 0.27,
                        color: Vx.red600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      child: Text(
                        'Đã bán 12,5k',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: DesignCourseAppTheme.nearlyBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: Row(
                        children: <Widget>[
                          RatingBarIndicator(
                            rating: double.parse(widget.rating),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            unratedColor: Colors.amber.withAlpha(50),
                            direction: Axis.horizontal,
                          ),
                          Text(
                            widget.rating,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                              letterSpacing: 0.27,
                              color: DesignCourseAppTheme.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: DesignCourseAppTheme.nearlyWhite,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              border: Border.all(
                                color: Vx.green500,
                              )),
                          child: GestureDetector(
                            onTap: () => {
                              print('Add to cart'),
                            },
                            child: const Icon(
                              Icons.add,
                              color: Vx.green500,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
