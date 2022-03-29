import 'package:lixshop/models/models.dart';

class ResponseDTO {
  int? err;
  String? msg;
  TokenResponse? dt;

  ResponseDTO({
    this.err,
    this.msg,
    this.dt,
  });

  factory ResponseDTO.fromJson(Map<String, dynamic> json) =>
      ResponseDTO(
        err: json["err"],
        msg: json["msg"],
        dt: json['dt'] != null? TokenResponse.fromJson(json["dt"]) : null,
      );

  Map<String, dynamic> toJson() =>
      {
        "err": err,
        "msg": msg,
        "dt": dt!.toJson(),
      };
}

