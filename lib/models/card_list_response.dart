import 'dart:core';

class CardListResponse {
  final int id;
  final String cardNumber;
  final String cvc;
  final String expMonth;
  final String expYear;

  String deliveryMethod = '';
  String pickupDeliveryDate = '';

  CardListResponse(
      this.id,
    this.cardNumber,
    this.cvc,
      this.expMonth,
      this.expYear
  );

  static CardListResponse fromMap(Map<String, dynamic> resp) {
    return CardListResponse(
      resp['id'] as int,
      resp['card_number'] as String,
      resp['cvc'] as String,
      resp['exp_month'] as String,
      resp['exp_year'] as String,
    );
  }
}
