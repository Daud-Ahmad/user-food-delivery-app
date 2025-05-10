import 'dart:core';

class TaxCharges {
  final String taxAmount;
  final String muraCharges;
  final String muraDriverCharges;
  final String deliveryCharges;
  final dynamic targetAmount;
  final dynamic userStatus;

  TaxCharges(
      this.taxAmount,
    this.muraCharges,
      this.muraDriverCharges,
      this.deliveryCharges,
      this.targetAmount,
      this.userStatus
  );

  static TaxCharges fromMap(Map<String, dynamic> resp) {
    return TaxCharges(
      resp['tax_amount'] as String,
      resp['mura_charges'] as String,
      resp['mura_driver_charges'] as String,
      resp['delivery_charges'] as String,
      resp['target_amount'] as dynamic,
      resp['user_status'] as dynamic,
    );
  }
}
