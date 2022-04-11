import '../models.dart';

class ResultDetailsDataModel {
  int? idBrand;
  List<String>? sizes;
  List<ProductSizesList>? productSizesList;

  ResultDetailsDataModel({
    this.idBrand,
    this.sizes,
    this.productSizesList,
  });

  factory ResultDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      ResultDetailsDataModel(
        idBrand: json["idBrand"],
        sizes: List<String>.from(json["sizes"].map((x) => x)),
        productSizesList: List<ProductSizesList>.from(
            json["sizeSanPhamDTOs"].map((x) => ProductSizesList.fromJson(x))),
      );
}