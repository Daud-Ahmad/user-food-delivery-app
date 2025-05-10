import 'dart:core';

import 'restaurant_list.dart';

class FavouriteRestaurant {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final dynamic rating;
  final dynamic totalReviews;
  final List<ResAddress>? resAddress;
  final ResTiming? resTiming;

  FavouriteRestaurant(
      this.id,
      this.name,
      this.email,
      this.phone,
      this.profileImage,
      this.rating,
      this.totalReviews,
      this.resAddress,
      this.resTiming
      );

  static FavouriteRestaurant fromMap(Map<String, dynamic> resp) {
    List<ResAddress>? resAddress;
    if (resp['address'] != null) {
      resAddress = List<ResAddress>.from(
          resp['address']?.map((item) => ResAddress.fromMap(item)));
    }
    return FavouriteRestaurant(
      resp['id'] as int,
      resp['name'] as String,
      resp['email'] as String,
      resp['phone'] as String,
      resp['profile_image'] as String,
        resp['rating'] as dynamic,
        resp['total_reviews'] as dynamic,
      resAddress,
        resp['timings'] == null ? null : ResTiming.fromMap(resp['timings'])
    );
  }
}
