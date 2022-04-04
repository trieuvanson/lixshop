class Register {
  String? phone;
  String? shopName;
  int? city;
  int? district;
  int? ward;
  String? address;

  Register({
    this.phone,
    this.shopName,
    this.city,
    this.district,
    this.ward,
    this.address,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        phone: json["phone"],
        shopName: json["shopName"],
        city: json["city"],
        district: json["district"],
        ward: json["ward"],
        address: json["address"],
      );

  //empty

  factory Register.empty() => Register(
        phone: null,
        shopName: null,
        city: null,
        district: null,
        ward: null,
        address: null,
      );


  Map<String, dynamic> toJson() => {
        "userName": phone,
        "name": shopName,
        "cityCusID": city,
        "guildCusID": ward,
        "numberAdd": address,
      };

  @override
  String toString() {
    return '''{
      "phone": $phone,
      "shopName": $shopName,
      "city": $city,
      "district": $district,
      "ward": $ward,
      "address": $address,
    }''';
  }
}
