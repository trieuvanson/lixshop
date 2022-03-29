class TokenResponse {
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  TokenResponse({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
        accessToken: json["accessToken"],
        tokenType: json["tokenType"],
        expiresIn: json["expiresIn"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "tokenType": tokenType,
        "expiresIn": expiresIn,
      };
}

class TokenResponseModel {
  TokenResponse? tokenResponse;
  String? error;

  TokenResponseModel({
    this.tokenResponse,
    this.error,
  });

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) =>
      TokenResponseModel(
        tokenResponse: TokenResponse.fromJson(json["token_response"]),
        error: "",
      );

  Map<String, dynamic> toJson() => {
        "token_response": tokenResponse?.toJson(),
        "error": error,
      };

  factory TokenResponseModel.withError(String error) => TokenResponseModel(
        tokenResponse: null,
        error: error,
      );
}
