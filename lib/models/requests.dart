
import 'orders_items_list.dart';

typedef ApiPayload = Map<String, dynamic>;

Future<ApiPayload> makeLoginRequest({
  required String email,
  required String password,
  String? token,
}) async {
  final Map<String, dynamic> req = {
    'email': email,
    'password': password,
    if(token != null && token.isNotEmpty)
    'token': token,
  };

  return req;
}

Future<ApiPayload> makeSignUpRequest({
  required String name,
  required String phone,
  required String email,
  required String password,
  String? token,
}) async {
  final Map<String, dynamic> req = {
    'name': name,
    'phone': phone,
    'email': email,
    'password': password,
    if(token != null && token.isNotEmpty)
      'token': token,
  };

  return req;
}

Future<ApiPayload> makeEmailOtpRequest({
  required String userId,
  required String otp,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'otp': otp,
  };

  return req;
}

Future<ApiPayload> makeRestaurantsListRequest({
  required String typeId,
  required String lat,
  required String long,
  required String? userId,
}) async {
  final Map<String, dynamic> req = {
    'type_id': typeId,
    'lat': lat,
    'long': long,
    if(userId != null)
    'user_id': userId,
  };
  return req;
}

Future<ApiPayload> makeAddNewCardRequest({
  required String? userId,
  required String cardNumber,
  required String expMonth,
  required String expYear,
  required String cvc,
  required String? cardId,
}) async {
  final Map<String, dynamic> req = {
    if(userId != null)
    'user_id': userId,
    'card_number': cardNumber,
    'exp_month': expMonth,
    'exp_year': expYear,
    'cvc': cvc,
    if(cardId != null)
    'card_id': cardId,
  };
  return req;
}

Future<ApiPayload> makeEditProfileRequest({
  required String userId,
  required String name,
  required String email,
  required String phone,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'name': name,
    'email': email,
    'phone': phone,
  };

  return req;
}

Future<ApiPayload> makeChangePasswordRequest({
  required String userId,
  required String oldPassword,
  required String newPassword,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'old_password': oldPassword,
    'new_password': newPassword,
  };

  return req;
}

Future<ApiPayload> makeLikeUnlikeResRequest({
  required String userId,
  required String prepperId,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'prepper_id': prepperId,
  };

  return req;
}

Future<ApiPayload> makeAddNewAddressRequest({
  required String userId,
  required String lat,
  required String long,
  required String streetAddress,
  required String title,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'lat': lat,
    'long': long,
    'street_address': streetAddress,
    'title': title,
  };

  return req;
}

Future<ApiPayload> makePlaceOrderRequest({
  required String userId,
  required String preperId,
  required String addressId,
  required String method,
  required String startTime,
  required String endTime,
  required String transactionId,
  required String pickupDeliveryDate,
  required String tax,
  required List<OrdersItemList> itemList,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'preper_id': preperId,
    'address_id': addressId,
    'method': method,
    'start_time': startTime,
    'end_time': endTime,
    'transaction_id': transactionId,
    'pickup_delivery_date': pickupDeliveryDate,
    'tax': tax,
    'items': List<dynamic>.from(itemList.map((x) => x.toMap())),

  };
  return req;
}

Future<ApiPayload> makePayWithStripeRequest({
  required String userId,
  required String preperId,
  required String cardId,
  required String amount,
  required String currency,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'prepper_id': preperId,
    'card_id': cardId,
    'amount': amount,
    'currency': currency,
  };
  return req;
}

Future<ApiPayload> makeAddReviewRequest({
  required String userId,
  required String preperId,
  required String orderId,
  required String rating,
  required String review,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'preper_id': preperId,
    'order_id': orderId,
    'rating': rating,
    'review': review,
  };
  return req;
}

Future<ApiPayload> makeForgetPasswordRequest({
  required String email,
}) async {
  final Map<String, dynamic> req = {
    'email': email,
  };

  return req;
}

Future<ApiPayload> makeSetPasswordRequest({
  required String userId,
  required String password,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'password': password,
  };

  return req;
}

Future<ApiPayload> makeContactUsRequest({
  required String userId,
  required String message,
  required String? image,
}) async {
  final Map<String, dynamic> req = {
    'user_id': userId,
    'message': message,
    if(image != null && image.isNotEmpty)
    'image': image,
  };

  return req;
}

Future<ApiPayload> makeSocialLoginRequest({
  required String name,
  required String email,
  required String? google,
  required String? apple,
  required String? facebook,
  required String phone,
  String? token,

}) async {
  final Map<String, dynamic> req = {
    'name': name,
    'email': email,
    'phone': phone,
    if(google != null && google.isNotEmpty)
    'google': google,
    if(apple != null && apple.isNotEmpty)
    'apple': apple,
    if(facebook != null && facebook.isNotEmpty)
    'facebook': facebook,
    if(token != null && token.isNotEmpty)
      'token': token,
  };

  return req;
}