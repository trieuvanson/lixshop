import 'package:flutter/material.dart';
import 'package:lixshop/models/models.dart';

import '../constants.dart';

enum ProductCardType {
  isNew,
  isSale,
  isHot,
}

class ProductCard extends StatelessWidget {
  final ProductOutsideBrand product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      margin: const EdgeInsets.only(
        left: kDefaultPadding / 2,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      child: Column(
        children: [
          Image.network(
            "https://lzd-img-global.slatic.net/g/p/91154bf9a81671b7c88b928533bffcc1.png_200x200q80.jpg_.webp",
            width: size.width * 0.4,
            height: size.height * 0.3,
            errorBuilder: (context, url, error) => SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.3,
              child: const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return const Center(child: Text('Loading...'));
              // You can use LinearProgressIndicator, CircularProgressIndicator, or a GIF instead
            },
            // loadingBuilder: (context, url, child) => SizedBox(
            //   width: size.width * 0.4,
            //   height: size.height * 0.3,
            //   child: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
            fit: BoxFit.fill,
          ),
          Container(
            padding: const EdgeInsets.all(kDefaultPadding / 3),
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
              height: 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      text: product.brandName!.toUpperCase(),
                      style: Theme.of(context).textTheme.button,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}