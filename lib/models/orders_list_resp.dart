import 'dart:core';

class OrdersListResp {
  final int id;
  final String preperId;
  final String status;
  final String method;
  final String amount;
  final String pickupDeliveryDate;
  final String addressId;
  final dynamic driverId;
  final dynamic startTime;
  final dynamic endTime;
  final UserDetail? userDetail;
  final PreperDetail? preperDetail;
  final List<OrdersItems>? itemDetailsList;

  OrdersListResp(
      this.id,
      this.preperId,
      this.status,
      this.method,
      this.amount,
      this.pickupDeliveryDate,
      this.addressId,
      this.driverId,
      this.startTime,
      this.endTime,
      this.userDetail,
      this.preperDetail,
      this.itemDetailsList
  );

  static OrdersListResp fromMap(Map<String, dynamic> resp) {
    List<OrdersItems>? itemDetailsList;
    if (resp['order_items'] != null) {
      itemDetailsList = List<OrdersItems>.from(
          resp['order_items']?.map((item) => OrdersItems.fromMap(item)));
    }
    return OrdersListResp(
      resp['id'] as int,
      resp['preper_id'] as String,
      resp['status'] as String,
      resp['method'] as String,
      resp['amount'] as String,
      resp['pickup_delivery_date'] as String,
      resp['address_id'] as String,
      resp['driver_id'] as dynamic,
        resp['start_time'] as dynamic,
        resp['end_time'] as dynamic,
        resp['user'] == null ? null : UserDetail.fromMap(resp['user']),
        resp['preper'] == null ? null : PreperDetail.fromMap(resp['preper']),
        itemDetailsList
    );
  }
}

class OrdersItems {
  final int id;
  final String orderId;
  final String menuId;
  final String qty;
  final List<ItemDetails>? itemDetailsList;

  OrdersItems(
      this.id,
      this.orderId,
      this.menuId,
      this.qty,
      this.itemDetailsList
      );

  static OrdersItems fromMap(Map<String, dynamic> resp) {
    List<ItemDetails>? itemDetailsList;
    if (resp['item_details'] != null) {
      itemDetailsList = List<ItemDetails>.from(
          resp['item_details']?.map((item) => ItemDetails.fromMap(item)));
    }
    return OrdersItems(
      resp['id'] as int,
      resp['order_id'] as String,
      resp['menu_id'] as String,
      resp['qty'] as String,
        itemDetailsList
    );
  }
}

class ItemDetails {
  final String title;
  final String price;

  ItemDetails(
      this.title,
      this.price,
      );

  static ItemDetails fromMap(Map<String, dynamic> resp) {
    return ItemDetails(
      resp['title'] as String,
      resp['price'] as String,
    );
  }
}

class UserDetail {
  final int id;
  final String name;
  final String email;
  final String phone;

  UserDetail(
      this.id,
      this.name,
      this.email,
      this.phone,
      );

  static UserDetail fromMap(Map<String, dynamic> resp) {
    return UserDetail(
      resp['id'] as int,
      resp['name'] as String,
      resp['email'] as String,
      resp['phone'] as String,
    );
  }
}

class PreperDetail {
  final int id;
  final String name;
  final String email;
  final String phone;
  final dynamic profileImage;

  PreperDetail(
      this.id,
      this.name,
      this.email,
      this.phone,
      this.profileImage
      );

  static PreperDetail fromMap(Map<String, dynamic> resp) {
    return PreperDetail(
      resp['id'] as int,
      resp['name'] as String,
      resp['email'] as String,
      resp['phone'] as String,
      resp['profile_image'] as dynamic,
    );
  }
}
