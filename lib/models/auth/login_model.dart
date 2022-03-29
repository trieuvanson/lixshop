class Login {
  String? username;
  String? password;

  Login({this.username, this.password});

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        username: json["userName"],
        password: json["pass"],
      );

  Map<String, dynamic> toJson() => {
        "userName": username,
        "pass": password,
      };
}

class LoginModel {
  Login? login;
  String? error;

  LoginModel({
    this.login,
    this.error,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        login: Login.fromJson(json["login"]),
        error: "",
      );

  factory LoginModel.withError(String error) =>
      LoginModel(error: error, login: null);

  Map<String, dynamic> toJson() => {
        "login": login?.toJson(),
      };
}
