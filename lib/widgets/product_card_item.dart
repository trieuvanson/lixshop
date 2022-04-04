import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/screen.dart';
import '../utils/design_course_app_theme.dart';

class ProductCardItem extends StatefulWidget {
  final String img;
  final String title;
  final String? stickers;
  final int idBrand;

  const ProductCardItem({
    Key? key,
    required this.img,
    required this.title,
    this.stickers,
    required this.idBrand,
  }) : super(key: key);

  @override
  _ProductCardItemState createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() =>  ProductDetailsScreen(
              idBrand: widget.idBrand,
            ));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        width: 180,
        height: 240,
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: DesignCourseAppTheme.notWhite,
          ),
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
                child: Image.network(
                  widget.img,
                  // loadingBuilder: (context, child, loadingProgress) {
                  //   if (loadingProgress == null)
                  //   return  child
                  //   else {
                  //     Center(
                  //       child: CircularProgressIndicator(
                  //        valueColor: AlwaysStoppedAnimation<Color>(
                  //          DesignCourseAppTheme.nearlyBlue,
                  //        ),
                  //       ),
                  //     );
                  //   }
                  // },
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4),
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.darkerText,
                ),
              ),
            ),
            Flexible(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
