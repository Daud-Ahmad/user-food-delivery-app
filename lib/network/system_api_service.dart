import 'dart:core';
import 'package:http/http.dart';

import '../models/address_list_response.dart';
import '../models/card_list_response.dart';
import '../models/favourite_restaurant.dart';
import '../models/forget_password_response.dart';
import '../models/general.dart';
import '../models/login_response.dart';
import '../models/menu_detail_response.dart';
import '../models/menu_response.dart';
import '../models/menu_type.dart';
import '../models/notifications.dart';
import '../models/orders_detail_resp.dart';
import '../models/orders_list_resp.dart';
import '../models/pay_stripe_resp.dart';
import '../models/requests.dart';
import '../models/restaurant_list.dart';
import '../models/reviews.dart';
import '../models/signup_response.dart';
import '../models/tax_charges.dart';
import 'api_client.dart';

abstract class SystemApiService {
  static Future<ApiSingleResponse<LoginResponse>> login(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'user/login',
      fromJson: LoginResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<LoginResponse>> socialLogin(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'social/login',
      fromJson: LoginResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<SignupResponse>> signUp(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'user/create',
      fromJson: SignupResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<LoginResponse>> verifyOtp(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'verify-otp',
      fromJson: LoginResponse.fromMap,
    );
  }

  static Future<ApiListResponse<MenuType>> gettingMenuTypeList() {
    return ApiClient.instance.callListApiGet(
      endPoint: 'menu-type',
      fromJson: MenuType.fromMap,
    );
  }

  static Future<ApiSingleResponse<RestaurantsList>> gettingRestaurantsList(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'resturants-list',
      fromJson: RestaurantsList.fromMap,
    );
  }

  static Future<ApiListResponse<MenuResponse>> gettingMenuList(preppersId) {
    return ApiClient.instance.callListApiGet(
      endPoint: 'menu-list/$preppersId',
      fromJson: MenuResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<MenuDetailResponse>> menuDetail(menuId) {
    return ApiClient.instance.callObjectApiGet(
      endPoint: 'menu/$menuId',
      fromJson: MenuDetailResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> addEditCard(ApiPayload req, endPoint) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: endPoint,
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiListResponse<CardListResponse>> cardList(String userId) {
    return ApiClient.instance.callListApiGet(
      endPoint: 'cards-list/$userId',
      fromJson: CardListResponse.fromMap,
    );
  }

  static Future<ApiListResponse<CardListResponse>> deleteCard(String cardId) {
    return ApiClient.instance.callListApiGet(
      endPoint: 'remove-card/$cardId',
      fromJson: CardListResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> editProfile(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'edit-profile',
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> changePassword(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'change-password',
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> likeUnlikePrepper(ApiPayload req, endPoint) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: endPoint,
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiListResponse<FavouriteRestaurant>> gettingFavouriteRestaurantsList(String userId) {
    return ApiClient.instance.callListApiGet(
      endPoint: 'favorite-list/$userId',
      fromJson: FavouriteRestaurant.fromMap,
    );
  }

  static Future<ApiListResponse<AddressListResponse>> addressList(String userId) {
    return ApiClient.instance.callListApiGet(
      endPoint: 'address-list/$userId',
      fromJson: AddressListResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> addNewAddress(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'add-address',
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> placeOrder(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'place-order',
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiListResponse<OrdersListResp>> userOrders(String ordersType, String userId) {
    return ApiClient.instance.callListApiGet(
      endPoint: 'user/$ordersType/$userId',
      fromJson: OrdersListResp.fromMap,
    );
  }

  static Future<ApiSingleResponse<PayStripeResp>> payWithStripe(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'pay-stripe',
      fromJson: PayStripeResp.fromMap,
    );
  }

  static Future<ApiSingleResponse<OrderDetailResp>> userOrdersDetail(String orderId) {
    return ApiClient.instance.callObjectApiGet(
      endPoint: 'order-details/$orderId',
      fromJson: OrderDetailResp.fromMap,
    );
  }

  static Future<ApiSingleResponse<TaxCharges>> taxCharges(String userId) {
    return ApiClient.instance.callObjectApiGet(
      endPoint: 'tax-charges/$userId',
      fromJson: TaxCharges.fromMap,
    );
  }

  static Future<ApiListResponse<Reviews>> reviewList(String restaurantId) {
    return ApiClient.instance.callListApiGet(
      endPoint: 'user/all-review/$restaurantId',
      fromJson: Reviews.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> addReview(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'user/add-review',
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> skipReview(String orderId) {
    return ApiClient.instance.callObjectApi(
      endPoint: 'user/skip/$orderId',
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<OrdersListResp>> checkOrderReviewedOrNot(String userId) {
    return ApiClient.instance.callObjectApi(
      endPoint: 'user/is-review/$userId',
      fromJson: OrdersListResp.fromMap,
    );
  }

  static Future<ApiListResponse<Notifications>> notifications(String userId) {
    return ApiClient.instance.callListApiGet(
      endPoint: 'user/notification/$userId',
      fromJson: Notifications.fromMap,
    );
  }

  static Future<ApiSingleResponse<ForgetPasswordResponse>> forgetPassword(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'forgot-password',
      fromJson: ForgetPasswordResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> setPassword(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'set-password',
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> imageUpload(MultipartFile req, location) {
    return ApiClient.instance.callFileApi(
        file: req,
        endPoint: 'upload-image',
        key: 'location',
        value: location,
        fromJson: GenericResponse.fromMap);
  }

  static Future<ApiSingleResponse<GenericResponse>> contactUs(ApiPayload req) {
    return ApiClient.instance.callObjectApi(
      req: req,
      endPoint: 'user/message-admin',
      fromJson: GenericResponse.fromMap,
    );
  }

  static Future<ApiSingleResponse<GenericResponse>> deleteAccount(String userId) {
    return ApiClient.instance.callObjectApiGet(
      endPoint: 'user/delete/$userId',
      fromJson: GenericResponse.fromMap,
    );
  }
}
