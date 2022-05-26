import '../../models/models.dart';
import '../../screens/home/widgets/product_card.dart';

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

  List<ProductOutsideBrand> getByCategory(
      {required List<ProductOutsideBrand> list,
      required String category}) {
    List<ProductOutsideBrand> productOutsideBrandList = [];
    for (var element in list) {
      if (element.brand == category) {
        productOutsideBrandList.add(element);
      }
    }
    return productOutsideBrandList;
  }



}
