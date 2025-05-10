import 'dart:core';

import 'restaurant_list.dart';

class OrdersItemList {
  final int id;
  final int qty;

  OrdersItemList(
      this.id,
      this.qty
      );

  static OrdersItemList fromMap(Map<String, dynamic> resp) {
    return OrdersItemList(
      resp['id'] as int,
      resp['qty'] as int,
    );
  }

   Map<String, dynamic> toMap() => {
    'id': id,
    'qty': qty,
  };
}
