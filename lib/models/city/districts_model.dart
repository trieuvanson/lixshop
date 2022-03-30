import '../models.dart';

class Districts {
  int? id;
  String? name;
  List<Wards>? wards;

  Districts({this.id, this.name, this.wards});

  factory Districts.fromJson(Map<String, dynamic> json) => Districts(
        id: json["id"],
        name: json["name"],
        wards: json["wards"] == null
            ? null
            : List<Wards>.from(json["wards"].map((x) => Wards.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "wards": wards == null ? null : wards!.map((x) => x.toJson()).toList(),
      };
}

class DistrictsModel {
  List<Districts>? districts;
  String? error;

  DistrictsModel({this.districts, this.error});

  factory DistrictsModel.fromJson(Map<String, dynamic> json) => DistrictsModel(
        districts: json["districts"] == null
            ? null
            : List<Districts>.from(
                json["districts"].map((x) => Districts.fromJson(x))),
        error: "",
      );

  factory DistrictsModel.withError(String error) => DistrictsModel(
        districts: [],
        error: error,
      );

  Map<String, dynamic> toJson() => {
        "districts": districts == null
            ? null
            : districts!.map((x) => x.toJson()).toList(),
        "error": error,
      };
}
