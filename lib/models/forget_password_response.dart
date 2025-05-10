import 'dart:core';

class ForgetPasswordResponse {
  final int id;
  final int opt;

  ForgetPasswordResponse(
      this.id,
      this.opt
  );

  static ForgetPasswordResponse fromMap(Map<String, dynamic> resp) {
    return ForgetPasswordResponse(
      resp['id'] as int,
      resp['opt'] as int,
    );
  }
}
