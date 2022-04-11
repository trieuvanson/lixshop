import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingWidget(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.black12,
    highlightColor: Colors.white38,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              for (int i in List.generate(5, (i) => i))
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: Container(
                    width: 150.0,
                    height: 180.0,
                    color: Colors.black,
                    child: Column(
                      children: [
                        Container(
                          height: 100.0,
                          width: 150,
                          color: Colors.black12,
                        ),
                        Container(
                          height: 100.0,
                          width: 150,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
            ],
          )),
    ),
  );
}
