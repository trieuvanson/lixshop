import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final int? username;
  final String? name;
  final String? phone;
  final String? address;

  const AuthUser({
    this.username,
    this.name,
    this.phone,
    this.address,
  });

  //Form json

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      username: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['stringAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': username,
      'name': name,
      'phone': phone,
      'stringAddress': address,
    };
  }

  //empty

  @override
  // TODO: implement props
  List<Object> get props => [
        username!,
        name!,
        phone!,
        address!,
      ];
}

class AuthUserResponse {
  final bool? isLoggedIn;
  final AuthUser? user;
  final bool? isError;

  const AuthUserResponse({
    this.isLoggedIn = false,
    this.user = const AuthUser(),
    this.isError = false,
  });

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) {
    return AuthUserResponse(
      isLoggedIn: json['isLoggedIn'],
      user: json['user'] != null ? AuthUser.fromJson(json['user']) : null,
      isError: json['isError'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoggedIn': isLoggedIn,
      'user': user?.toJson(),
      'isError': isError,
    };
  }


}
