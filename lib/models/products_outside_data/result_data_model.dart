import '../models.dart';

class ResultDataModel {
  String? idNpp;
  double? createDate;
  String? createUser;
  List<ProductOutsideCategory>? productOutsideCategory;

  ResultDataModel({
    this.idNpp,
    this.createDate,
    this.createUser,
    this.productOutsideCategory,
  });

  factory ResultDataModel.fromJson(Map<String, dynamic> json) =>
      ResultDataModel(
        idNpp: json["idnpp"].toInt().toString(),
        createDate: json["createDate"].toDouble(),
        createUser: json["createUser"],
        productOutsideCategory: json["cateSanPhams"] == null
            ? null
            : List<ProductOutsideCategory>.from(json["cateSanPhams"]
                .map((x) => ProductOutsideCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idnpp": idNpp,
        "createDate": createDate,
        "createUser": createUser,
        "cateSanPhams": productOutsideCategory == null
            ? null
            : List<dynamic>.from(
                productOutsideCategory!.map((x) => x.toJson())),
      };
}
