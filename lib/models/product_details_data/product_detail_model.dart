import '../models.dart';
class ProductDetail {
  int? idAgent;
  String? nameAgent;
  String? code;
  String? name;
  String? unit;
  double? wunit;
  int? changeValue;
  int? price;
  String? pathImg;
  String? description;
  List<VoucherMethod>? voucherMethods;


  ProductDetail({
    this.idAgent,
    this.nameAgent,
    this.code,
    this.name,
    this.unit,
    this.wunit,
    this.changeValue,
    this.pathImg,
    this.price,
    this.description,
    this.voucherMethods,
  });

  // FromJson
  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
      idAgent: json["idagent"],
      nameAgent: json["nameAgent"],
      code: json["code"],
      name: json["name"],
      unit: json["unit"],
      wunit: json["wunit"].toDouble(),
      changeValue: json["changeValue"],
      pathImg: json["pathImg"],
      price: json["gia"],
      description: json["description"],
      voucherMethods: List<VoucherMethod>.from(
          json["hinhThucKMDTOs"].map((x) => VoucherMethod.fromJson(x)))
  );

  // ToJson
  Map<String, dynamic> toJson() => {
    "idagent": idAgent,
    "nameAgent": nameAgent,
    "code": code,
    "name": name,
    "unit": unit,
    "wunit": wunit,
    "changeValue": changeValue,
    "pathImg": pathImg,
    "gia": price,
    "description": description,
    "hinhThucKMDTOs": List<dynamic>.from(voucherMethods!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'ProductDetail{idAgent: $idAgent, code: $code, name: $name, unit: $unit, wunit: $wunit, changeValue: $changeValue, price: $price, pathImg: $pathImg, voucherMethods: $voucherMethods}';
  }
}