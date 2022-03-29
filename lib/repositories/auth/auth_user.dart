import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
 final String? username;
 final String? email;
 final  String? phone;
 final String? firstName;
 final  String? lastName;
 final  String? avatar;

  AuthUser({
    this.username,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  //Form json

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        "firstName": firstName,
        "lastName": lastName,
        "avatar": avatar,
      };

  //empty
  factory AuthUser.empty() => AuthUser(
        username: null,
        email: null,
        phone: null,
        firstName: null,
        lastName: null,
        avatar: null,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        username,
        email,
        phone,
        firstName,
        lastName,
        avatar,
      ];
}
