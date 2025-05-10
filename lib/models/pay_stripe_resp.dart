import 'dart:core';

class PayStripeResp {
  final int transactionId;
  final String paymentId;
  final String amount;

  PayStripeResp(
      this.transactionId,
    this.paymentId,
    this.amount,
  );

  static PayStripeResp fromMap(Map<String, dynamic> resp) {
    return PayStripeResp(
      resp['transaction_id'] as int,
      resp['payment_id'] as String,
      resp['amount'] as String,
    );
  }
}
