import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum CategoryLoaderType { loading, error }

class CategoryItemsLoader extends StatelessWidget {
  final CategoryLoaderType type;

  const CategoryItemsLoader({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return type == CategoryLoaderType.loading
        ? Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300]!,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Row(
                      children: [
                        for (var i = 0; i < 15; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100.0,
                              height: 130 + padding.top,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130 + padding.top,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Chưa cài đặt dữ liệu cho khu vực này',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
