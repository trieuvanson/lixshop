import 'package:flutter/material.dart';
import 'package:lixshop/models/restaurants.dart';

import '../../utils/design_course_app_theme.dart';
import '../product/products_screen.dart';

class HomeScreenProductsType extends StatefulWidget {
  const HomeScreenProductsType({Key? key}) : super(key: key);

  @override
  _HomeScreenProductsTypeState createState() => _HomeScreenProductsTypeState();
}

class _HomeScreenProductsTypeState extends State<HomeScreenProductsType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DesignCourseAppTheme.nearlyWhite,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: DesignCourseAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, top: 4.0, bottom: 4.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              restaurants.length,
                  (index) => ProductTypeCard(
                imagePath: restaurants[index]['img'],
                title: restaurants[index]['type'],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTypeCard extends StatefulWidget {
  final String imagePath;
  final String title;

  const ProductTypeCard(
      {Key? key, required this.imagePath, required this.title})
      : super(key: key);

  @override
  _ProductTypeCardState createState() => _ProductTypeCardState();
}

class _ProductTypeCardState extends State<ProductTypeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductsScreen(),
            settings: const RouteSettings(
              name: '/products',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 130,
          decoration: BoxDecoration(
            color: DesignCourseAppTheme.nearlyWhite,
            borderRadius: BorderRadius.circular(10),
            border:
            Border.all(color: DesignCourseAppTheme.grey.withOpacity(0.2)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: DesignCourseAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 8.0),
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
                    widget.imagePath,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 4, right: 8),
                child: Center(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: DesignCourseAppTheme.darkerText,
                    ),
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
