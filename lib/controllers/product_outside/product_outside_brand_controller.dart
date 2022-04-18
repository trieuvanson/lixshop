import 'package:lixshop/screens/home1/widgets/product_card.dart';

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
      {required ProductCardType type,
      required List<ProductOutsideBrand> list}) {
    List<ProductOutsideBrand> productOutsideBrandList = [];
    switch (type) {
      case ProductCardType.isNew:
        productOutsideBrandList =
            list.where((element) => element.isNew!).toList();
        break;
      case ProductCardType.isSale:
        productOutsideBrandList =
            list.where((element) => element.isSale!).toList();
        break;
      case ProductCardType.isHot:
        productOutsideBrandList =
            list.where((element) => element.isHot!).toList();
        break;
      default:
        return [];
    }
    return productOutsideBrandList;
  }
}

final productOutsideBrandController = ProductOutsideBrandController();
