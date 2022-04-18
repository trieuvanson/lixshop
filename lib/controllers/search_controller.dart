import 'package:lixshop/models/filters/category_filter.dart';
import 'package:lixshop/models/models.dart';

class SearchController {
  List<ProductOutsideCategory> searchAndFilter({
    required String keyword,
    required List<CategoryFilter> filter,
    required List<ProductOutsideCategory> categories,
  }) {
    List<ProductOutsideCategory> result = categories;
    bool checkAll = filter.where((element) => !element.isSelected!).length == filter.length;
    print('checkAll: $checkAll');
    print(categories.length);
    if (!checkAll) {
      for (CategoryFilter categoryFilter in filter) {
        if (categoryFilter.isSelected!) {
          result.removeWhere((element) => element.cateId != categoryFilter.id);
        }
      }

    }
    if (result.isNotEmpty) {
      for (var rs  in result) {
        rs.productBrand!.removeWhere((element) =>
        (element.brandName!.toLowerCase().contains(keyword.toLowerCase()) ==
            false));
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
