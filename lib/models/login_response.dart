import 'dart:core';

class LoginResponse {
  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic phone;

  LoginResponse(
      this.id,
    this.name,
    this.email,
      this.phone
  );

  static LoginResponse fromMap(Map<String, dynamic> resp) {
    return LoginResponse(
      resp['id'] as dynamic,
      resp['name'] as dynamic,
      resp['email'] as dynamic,
      resp['phone'] as dynamic,
    );
  }
}
