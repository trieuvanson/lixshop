import '../models.dart';

class ProductsData {
  String? idNpp;
  double? createDate;
  String? createUser;
  List<ProductCate>? productCate;

  ProductsData({
    this.idNpp,
    this.createDate,
    this.createUser,
    this.productCate,
  });

  factory ProductsData.fromJson(Map<String, dynamic> json) => ProductsData(
        idNpp: json["idnpp"].toInt().toString(),
        createDate: json["createDate"].toDouble(),
        createUser: json["createUser"],
        productCate: json["cateSanPhams"] == null
            ? null
            : List<ProductCate>.from(
                json["cateSanPhams"].map((x) => ProductCate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "idNpp": idNpp == null ? null : idNpp,
        "createDate": createDate == null ? null : createDate,
        "createUser": createUser == null ? null : createUser,
        "cateSanPhams": productCate == null
            ? null
            : List<dynamic>.from(productCate!.map((x) => x.toJson())),
      };
}

class ProductsDataModel {
  ProductsData? data;
  String? error;

  ProductsDataModel({
    this.data,
    this.error,
  });

  factory ProductsDataModel.fromJson(Map<String, dynamic> json) =>
      ProductsDataModel(
        data: ProductsData.fromJson(json),
        error: json["error"],
      );

  factory ProductsDataModel.withError(String error) =>
      ProductsDataModel(data: null, error: error);
}
