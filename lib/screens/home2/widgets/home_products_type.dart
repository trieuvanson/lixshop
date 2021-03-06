import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lixshop/core/core.dart';
import 'package:lixshop/models/models.dart';

import '../../../utils/design_course_app_theme.dart';
import '../../search/search_results.dart';

class HomeProductsType extends StatefulWidget {
  const HomeProductsType({Key? key}) : super(key: key);

  @override
  _HomeProductsTypeState createState() => _HomeProductsTypeState();
}

class _HomeProductsTypeState extends State<HomeProductsType> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultOutsideCubit, ResultOutsideState>(
      builder: (context, state) {
        if (state.isLoading) {
          return _buildLoadingWidget();
        } else if (state.isError) {
          return Container();
        } else if (state.isSuccess) {
          return _buildCategoriesWidget(state.resultDataModel!);
        }
        return Container();
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: 25.0,
            height: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoriesWidget(
      ResultDataModel resultDataModel /*TrailersModel data*/) {
    // List<Video>? videos = data.trailers;
    List<ProductOutsideCategory> categories =
    resultDataModel.productOutsideCategory!;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: DesignCourseAppTheme.nearlyWhite,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: DesignCourseAppTheme.notWhite,
              offset: Offset(1.1, 1.1),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
                  (index) => ProductTypeCard(
                category: categories[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTypeCard extends StatefulWidget {
  final category;

  const ProductTypeCard({Key? key, this.category}) : super(key: key);

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
            builder: (context) => SearchResults(
              keyword: widget.category.name!,
              // category: widget.category,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: 180,
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
                child: Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      widget.category.catePath,
                      height: 100,
                      errorBuilder: (context, url, error) => const SizedBox(
                        height: 100,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                      loadingBuilder: (context, child, progress) =>
                      progress == null
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
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 4, right: 8),
                child: Center(
                  child: Text(
                    widget.category.cateName,
                    textAlign: TextAlign.left,
                    maxLines: 1,
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
