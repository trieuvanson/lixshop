
import '../../models/models.dart';

class ProductOutsideBrandController {
  List<ProductOutsideBrand> getProductOutsideBrandList(
      ResultDataModel resultDataModel) {
    List<ProductOutsideBrand> productOutsideBrandList = [];
    for (var element in resultDataModel.productOutsideCategory!) {
      productOutsideBrandList.addAll(element.productBrand!);
    }
    return productOutsideBrandList;
  }

  List<ProductOutsideBrand> filterProductsBrand(
      {required bool isHot,
      required bool isNew,
      required bool isSale,
      required List<ProductOutsideBrand> list}) {
    List<ProductOutsideBrand> productOutsideBrandList = [];
    if (isHot) {
      productOutsideBrandList =
          list.where((element) => element.isHot!).toList();
    } else if (isNew) {
      productOutsideBrandList =
          list.where((element) => element.isNew!).toList();
    } else if (isSale) {
      productOutsideBrandList =
          list.where((element) => element.isSale!).toList();
    } else {
      return [];
    }
    return productOutsideBrandList;
  }
}

final productOutsideBrandController = ProductOutsideBrandController();
