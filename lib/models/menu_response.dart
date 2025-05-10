import 'dart:core';

import 'restaurant_list.dart';

class MenuResponse {
  final int? id;
  final String? preperId;
  final String? type;
  final String? dietaryType;
  final String? cuisine;
  final String? deliveryType;
  final String title;
  final String description;
  final String quantity;
  final String price;
  final dynamic image;
  final dynamic instructions;

  int totalItems = 0;
  double deliveryFee = 0.00;
  String restaurantName = '';
  ResTiming? resTiming;

  MenuResponse(
      this.id,
      this.preperId,
      this.type,
      this.dietaryType,
      this.cuisine,
      this.deliveryType,
      this.title,
      this.description,
      this.quantity,
      this.price,
      this.image,
      this.instructions
      );

  static MenuResponse fromMap(Map<String, dynamic> resp) {
    return MenuResponse(
      resp['id'] as int?,
      resp['preper_id'] as String?,
      resp['type_id'] as String?,
      resp['dietary_type_id'] as String?,
      resp['cuisine_id'] as String?,
      resp['delivery_type_id'] as String?,
      resp['title'] as String,
      resp['description'] as String,
      resp['quantity'] as String,
      resp['price'] as String,
      resp['image'] as dynamic,
      resp['instructions'] as dynamic,
    );
  }

   Map<String, dynamic> toMap() => {
    'id': id,
    'preper_id': preperId,
    'type_id': type,
    'dietary_type_id': dietaryType,
    'title': title,
    'description': description,
    'quantity': quantity,
    'price': price,
    'image': image,
    'instructions': instructions,
  };

  int getTotalPrice(){
    int itemPrice = int.parse(price);
    return totalItems * itemPrice;
  }
}
