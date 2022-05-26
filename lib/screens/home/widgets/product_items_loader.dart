import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/constants.dart';

enum ProductLoaderType {
  loading,
  error,
}

class ProductItemsLoader extends StatelessWidget {
  final ProductLoaderType type;

  const ProductItemsLoader({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (type == ProductLoaderType.loading) {
      return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300]!,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [
                  for (var i = 0; i < 3; i++)
                    Container(
                      width: size.width * 0.4,
                      margin: const EdgeInsets.only(
                        left: kDefaultPadding / 2,
                        top: kDefaultPadding / 2,
                        bottom: kDefaultPadding * 2.5,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.4,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              color: kBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                            child: Container(
                              color: kBackgroundColor,
                              width: size.width * 0.4,
                              height: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
    } else {
      return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i = 0; i < 3; i++)
                  Container(
                    width: size.width * 0.4,
                    margin: const EdgeInsets.only(
                      left: kDefaultPadding / 2,
                      top: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2.5,
                    ),
                    child: Container(
                      width: size.width * 0.4,
                      height: size.height * 0.3 + 50,
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
                      child: const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
    }
  }
}
