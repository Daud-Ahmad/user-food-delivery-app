import 'dart:core';

class AddressListResponse {
  final int id;
  final String title;
  final String streetAddress;
  final String lat;
  final String long;

  AddressListResponse(
      this.id,
    this.title,
    this.streetAddress,
      this.lat,
      this.long
  );

  static AddressListResponse fromMap(Map<String, dynamic> resp) {
    return AddressListResponse(
      resp['id'] as int,
      resp['title'] as String,
      resp['street_address'] as String,
      resp['lat'] as String,
      resp['long'] as String,
    );
  }
}
