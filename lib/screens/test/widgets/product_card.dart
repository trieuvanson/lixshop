import 'package:flutter/material.dart';

import '../constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      margin: const EdgeInsets.only(
        left: kDefaultPadding /2,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      child: Column(
        children: [
          Image.network(
            "https://lzd-img-global.slatic.net/g/p/7d23ea1094f6ec174d13cd0d90433f25.jpg_200x200q80.jpg_.webp",
            width: size.width * 0.4,
            height: size.height * 0.3,
            fit: BoxFit.fill,
          ),
          Container(
            padding:
            const EdgeInsets.all(kDefaultPadding / 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: SizedBox(
              width: size.width * 0.4,
              height: 45,
              child: RichText(
                text: TextSpan(
                    text:
                    "Đây là sản phẩm từ 1 số nơi nào đó"
                        .toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .button),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
