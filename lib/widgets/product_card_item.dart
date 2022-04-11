import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/models/models.dart';

import '../screens/screen.dart';
import '../utils/design_course_app_theme.dart';

class ProductCardItem extends StatefulWidget {
  final product;
  final String? stickers;

  const ProductCardItem({
    Key? key,
    this.stickers,
    required this.product,
  }) : super(key: key);

  @override
  _ProductCardItemState createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailsScreen(
              idBrand: widget.product.brandId.toInt(),
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
                  widget.product.brand,
                  errorBuilder: (context, url, error) => const SizedBox(
                    height: 180,
                    child: Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : const SizedBox(
                          height: 180,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black,
                              ),
                            ),
                          ),
                        ),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4),
              child: Text(
                widget.product.brandName,
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
