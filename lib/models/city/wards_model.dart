class Wards {
  int? id;
  String? name;

  Wards({this.id, this.name});

  factory Wards.fromJson(Map<String, dynamic> json) => Wards(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return 'Wards{id: $id, name: $name}';
  }
}

class WardsModel {
  List<Wards>? wards;
  String? error;

  WardsModel({this.wards, this.error});

  factory WardsModel.fromJson(Map<String, dynamic> json) => WardsModel(
        wards: List<Wards>.from(json["wards"].map((x) => Wards.fromJson(x))),
        error: "",
      );

  factory WardsModel.withError(String error) => WardsModel(
        wards: [],
        error: error,
      );

  Map<String, dynamic> toJson() => {
        "wards": wards!.map((x) => x.toJson()).toList(),
        "error": error,
      };

  @override
  String toString() {
    return 'WardsModel{wards: $wards}';
  }
}
