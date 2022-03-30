import '../models.dart';

class City {
  int? id;
  String? name;
  List<Districts>? districts;

  City({this.id, this.name, this.districts});

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        districts: json["districts"] == null
            ? null
            : List<Districts>.from(
                json["districts"].map((x) => Districts.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "districts": districts == null
            ? null
            : districts!.map((x) => x.toJson()).toList(),
      };
}

class CityModel {
  List<City>? cities;
  String? error;

  CityModel({this.cities, this.error});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
        error: "",
      );

  factory CityModel.withError(String error) => CityModel(
        cities: [],
        error: error,
      );

  Map<String, dynamic> toJson() => {
        "": cities == null ? null : cities!.map((x) => x.toJson()).toList(),
        "error": error,
      };
}
