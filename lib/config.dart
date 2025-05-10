
import 'models/address_list_response.dart';
import 'models/menu_response.dart';

abstract class AppConfig {
  static String imageBaseUrl = 'https://muraadmin.com/';
  static String googleMapApiKey = 'YOUR_API_KEY';

  static List<MenuResponse> menuResponseList = [];
  static List<AddressListResponse> addressList = [];

  static bool isFirstTimeAppOpen = true;

  static const String PAYMENT_TYPE = 'gbp';

  static const String ACTIVE_ORDERS = 'order-active';
  static const String PENDING_ORDERS = 'order-pending';
  static const String CANCEL_ORDERS = 'order-canceled';
  static const String COMPLETED_ORDERS = 'order-completed';
  static const String DELIVERY = 'delivery';
  static const String blockedUserValue = '2';

  static int? addressId;

  static double subTotal = 0;
  static double deliveryFee = 0.00;
  static double discount = 0;
  static double salesTax = 0;
  static double total = 0;

  static String deliveryMethod = '';
  static String pickupDeliveryDate = '';

  static double? latitude;
  static double? longitude;
  static String deliveryAddress = '';

  static String? token;
}
