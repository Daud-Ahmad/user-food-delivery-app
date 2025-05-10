import 'dart:core';

class SignupResponse {
  final dynamic id;
  final dynamic otp;

  SignupResponse(
      this.id,
    this.otp,
  );

  static SignupResponse fromMap(Map<String, dynamic> resp) {
    return SignupResponse(
      resp['id'] as dynamic,
      resp['otp'] as dynamic,
    );
  }
}
