import 'dart:core';

class RestaurantsList {
  final List<Restaurant>? nearYouRestaurants;
  final List<Restaurant>? popularRestaurants;

  RestaurantsList(
      this.nearYouRestaurants,
      this.popularRestaurants
      );

  static RestaurantsList fromMap(Map<String, dynamic> resp) {
    List<Restaurant>? nearYouRestaurants;
    List<Restaurant>? popularRestaurants;
    if (resp['near_you'] != null) {
      nearYouRestaurants = List<Restaurant>.from(
          resp['near_you']?.map((item) => Restaurant.fromMap(item)));
    }
    if (resp['popular'] != null) {
      popularRestaurants = List<Restaurant>.from(
          resp['popular']?.map((item) => Restaurant.fromMap(item)));
    }
    return RestaurantsList(
      nearYouRestaurants,
      popularRestaurants
    );
  }
}

class Restaurant {
  final int id;
  int liked;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final String role;
  final dynamic rating;
  final dynamic totalReviews;
  final List<ResAddress>? resAddress;
  final ResTiming? resTiming;

  Restaurant(
      this.id,
      this.liked,
      this.name,
      this.email,
      this.phone,
      this.profileImage,
      this.role,
      this.rating,
      this.totalReviews,
      this.resAddress,
      this.resTiming
      );

  static Restaurant fromMap(Map<String, dynamic> resp) {
    List<ResAddress>? resAddress;
    if (resp['address'] != null) {
      resAddress = List<ResAddress>.from(
          resp['address']?.map((item) => ResAddress.fromMap(item)));
    }
    return Restaurant(
      resp['id'] as int,
        resp['liked'] as int,
      resp['name'] as String,
      resp['email'] as String,
      resp['phone'] as String,
      resp['profile_image'] as String,
      resp['role'] as String,
        resp['rating'] as dynamic,
        resp['total_reviews'] as dynamic,
      resAddress,
        resp['timings'] == null ? null : ResTiming.fromMap(resp['timings'])
    );
  }
}

class ResTiming {
  final int id;
  final String orderDays;
  final String tillDate;
  final String deliveryDay;
  final String startTime;
  final String endTime;

  ResTiming(
      this.id,
      this.orderDays,
      this.tillDate,
      this.deliveryDay,
      this.startTime,
      this.endTime
      );

  static ResTiming fromMap(Map<String, dynamic> resp) {
    return ResTiming(
      resp['id'] as int,
      resp['order_days'] as String,
      resp['till_date'] as String,
      resp['delivery_day'] as String,
      resp['start_time'] as String,
      resp['end_time'] as String,
    );
  }
}

class ResAddress {
  final int id;
  final String title;
  final String streetAddress;
  final String lat;
  final String long;

  ResAddress(
      this.id,
      this.title,
      this.streetAddress,
      this.lat,
      this.long,
      );

  static ResAddress fromMap(Map<String, dynamic> resp) {
    return ResAddress(
      resp['id'] as int,
      resp['title'] as String,
      resp['street_address'] as String,
      resp['lat'] as String,
      resp['long'] as String,
    );
  }
}
