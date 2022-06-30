class ProductSlideDTO {
  double? id;
  String? code;
  String? name;

  ProductSlideDTO({
    this.id,
    this.code,
    this.name,
  });

  factory ProductSlideDTO.fromMap(Map<String, dynamic> json) => ProductSlideDTO(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "name": name,
      };
}
