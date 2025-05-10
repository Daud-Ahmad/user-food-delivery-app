import 'dart:core';

class MenuType {
  final int id;
  final String name;
  final dynamic image;

  bool isSelected = false;

  MenuType(
      this.id,
    this.name,
      this.image
  );

  static MenuType fromMap(Map<String, dynamic> resp) {
    return MenuType(
      resp['id'] as int,
      resp['name'] as String,
      resp['image'] as dynamic,
    );
  }
}
