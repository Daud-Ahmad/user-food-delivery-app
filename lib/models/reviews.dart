import 'dart:core';

import 'orders_list_resp.dart';

class Reviews {
  final String review;
  final String rating;
  final UserDetail? userDetail;

  Reviews(
      this.review,
    this.rating,
      this.userDetail,
  );

  static Reviews fromMap(Map<String, dynamic> resp) {
    return Reviews(
      resp['review'] as String,
      resp['rating'] as String,
      resp['user'] == null ? null : UserDetail.fromMap(resp['user']),
    );
  }
}
