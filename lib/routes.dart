

import 'package:flutter/cupertino.dart';
import 'package:mura_user_app/ui/home/profile/my_address/address_list_vu.dart';

import 'ui/auth/login/login_vu.dart';
import 'ui/auth/reset_password/reset_vu.dart';
import 'ui/auth/signup/signup_vu.dart';
import 'ui/get_rating/get_rating_vu.dart';
import 'ui/home/cart_screen/payment/change_payment_method/change_payment_method_vu.dart';
import 'ui/home/cart_screen/payment/credit_card_info/credit_card_info_vu.dart';
import 'ui/home/cart_screen/payment/payment_method/payment_method_vu.dart';
import 'ui/home/cart_screen/payment/payment_vu.dart';
import 'ui/home/cart_screen/payment/paymeny_method_2/payment_method2_vu.dart';
import 'ui/home/home_restaurant_list/home_restaurant_filter/home_restaurant_filter_vu.dart';
import 'ui/home/home_restaurant_list/home_restaurant_list_vu.dart';
import 'ui/home/home_vu.dart';
import 'ui/home/orders/orders_details/order_details_screen_vu.dart';
import 'ui/home/profile/change_password/change_password_vu.dart';
import 'ui/home/profile/contact_us/contact_us_vu.dart';
import 'ui/home/profile/edit_profile/edit_profile_vu.dart';
import 'ui/home/profile/my_address/my_address_vu.dart';
import 'ui/home/profile/notifications/notifications_vu.dart';
import 'ui/home/profile/subscription/orders_list/orders_list_vu.dart';
import 'ui/home/profile/subscription/subscription_vu.dart';
import 'ui/lets_start/lets_start_vu.dart';
import 'ui/order_successfully_placed/order_place_successfully_vu.dart';
import 'ui/rastaurant_menu/restaurant_menu_vu.dart';
import 'ui/rating/certificate_review_vu.dart';
import 'ui/restaurant_detail/restaurant_detail_vu.dart';
import 'ui/splash/splash_vu.dart';
import 'ui/track_your_order/track_your_order_vu.dart';

Map<String, WidgetBuilder> appRoutes = {

  '/': (context) => const SplashScreen(),

  '/login_screen': (context) => const LoginScreen(),

  '/signup_screen': (context) => const SignupScreen(),

  '/reset_password_screen': (context) => const ResetPasswordScreen(),

  '/lets_start_screen': (context) => const LetsStartScreen(),

  '/home_screen': (context) => const HomeScreen(),

  '/home_restaurant_list_screen': (context) => const HomeRestaurantListScreen(),

  '/edit_profile_screen': (context) => const EditProfileScreen(),

  '/change_password_screen': (context) => const ChangePasswordScreen(),

  '/subscription_screen': (context) => const SubscriptionScreen(),

  '/orders_list_screen': (context) => const OrdersListScreen(),

  '/contact_us_screen': (context) => const ContactUsScreen(),

  '/order_detail_screen': (context) => const OrderDetailScreen(),

  '/notifications_screen': (context) => const NotificationsScreen(),


  '/payment_screen': (context) => const PaymentScreen(),

  '/payment_method_screen': (context) => const PaymentMethodScreen(),

  '/payment_method2_screen': (context) => const PaymentMethod2Screen(),

  '/credit_card_info_screen': (context) => const CreditCardInfoScreen(),

  '/change_payment_method_screen': (context) => const ChangePaymentMethodScreen(),

  '/restaurant_detail_screen': (context) => const RestaurantDetailScreen(),

  '/restaurant_menu_screen': (context) => const RestaurantMenuScreen(),

  '/my_address_screen': (context) => const MyAddressScreen(),

  '/home_restaurant_filter_screen': (context) => const HomeRestaurantFilterScreen(),

  '/order_place_successfully_screen': (context) => const OrderPlaceSuccessfullyScreen(),

  '/track_your_order_screen': (context) => const TrackYourOrderScreen(),

  '/address_list_screen': (context) => const AddressListScreen(),

  '/certificate_review_screen': (context) => const CertificateReviewScreen(),

  '/get_rating_screen': (context) => const GetRatingScreen(),

};
