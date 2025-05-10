import 'dart:core';

class MenuDetailResponse {
  final int id;
  final String preperId;
  final String title;
  final String description;
  final String quantity;
  final String price;
  final dynamic image;
  final dynamic instructions;
  final Type cuisine;
  final Type type;
  final Type dietry;
  final Type delivery;

  MenuDetailResponse(
      this.id,
      this.preperId,
      this.title,
      this.description,
      this.quantity,
      this.price,
      this.image,
      this.instructions,
      this.cuisine,
      this.type,
      this.dietry,
      this.delivery
      );

  static MenuDetailResponse fromMap(Map<String, dynamic> resp) {
    return MenuDetailResponse(
      resp['id'] as int,
      resp['preper_id'] as String,
      resp['title'] as String,
      resp['description'] as String,
      resp['quantity'] as String,
      resp['price'] as String,
      resp['image'] as dynamic,
      resp['instructions'] as dynamic,
      Type.fromMap(resp['cuisine']),
      Type.fromMap(resp['type']),
      Type.fromMap(resp['dietry']),
      Type.fromMap(resp['delivery']),
    );
  }
}



class Type {
  final int id;
  final String name;

  Type(
      this.id,
      this.name,
      );

  static Type fromMap(Map<String, dynamic> resp) {
    return Type(
      resp['id'] as int,
      resp['name'] as String,
    );
  }
}
