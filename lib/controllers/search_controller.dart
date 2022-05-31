import 'package:lixshop/models/models.dart';

import '../models/filters/category_filter.dart';
import '../utils/convert/vi_to_en/vietnamese_parser_engine.dart';

class SearchController {
  List<ProductOutsideCategory> searchAndFilter({
    required String keyword,
    required List<CategoryFilter> filter,
    required List<ProductOutsideCategory> categories,
  }) {
    List<ProductOutsideCategory> result = [];
    bool checkAll =
        filter.where((element) => !element.isSelected!).length == filter.length;
    if (!checkAll) {
      for (CategoryFilter categoryFilter in filter) {
        if (categoryFilter.isSelected!) {
          for (ProductOutsideCategory category in categories) {
            if (category.cateId == categoryFilter.id) {
              result.add(category);
            }
          }
        }
      }
    }
    for (var rs in result) {
      rs.productBrand!.removeWhere((element) =>
          (element.brandName!.toLowerCase().contains(keyword.toLowerCase()) ==
              false));
    }

    return result;
  }





  List<ProductOutsideBrand> search(
      {required String keyword,
      required List<ProductOutsideCategory> categories}) {
    List<ProductOutsideBrand> result = [];
    for (var rs in categories) {
      for (var element in rs.productBrand!) {
        if (vietnameseParserEngine
            .unsigned(element.brandName!.toLowerCase())
            .contains(vietnameseParserEngine.unsigned(keyword.toLowerCase()))) {
          result.add(element);
        }
      }
    }
    return result;
  }

  List<ProductOutsideBrand> getByCategories(
      List<ProductOutsideCategory> categories) {
    List<ProductOutsideBrand> list = [];
    for (var category in categories) {
      list.addAll(category.productBrand!);
    }
    return list;
  }
}

final searchController = SearchController();
