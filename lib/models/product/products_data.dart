import '../models.dart';

class ProductsData {
  // double? idNpp;
  double? createDate;
  String? createUser;
  List<ProductCate>? productCate;

  ProductsData({
    // this.idNpp,
    this.createDate,
    this.createUser,
    this.productCate,
  });

  factory ProductsData.fromJson(Map<String, dynamic> json) => ProductsData(
        // idNpp: json["idNpp"] == null ? null : json["idNpp"].toDouble(),
        createDate: json["createDate"].toDouble(),
        createUser: json["createUser"],
        productCate: json["cateSanPhams"] == null
            ? null
            : List<ProductCate>.from(
                json["cateSanPhams"].map((x) => ProductCate.fromJson(x))),
      );
}


