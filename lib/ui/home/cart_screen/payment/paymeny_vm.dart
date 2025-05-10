import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/alerts.dart';
import '../../../../config.dart';
import '../../../../models/card_list_response.dart';
import '../../../../models/orders_items_list.dart';
import '../../../../models/pay_stripe_resp.dart';
import '../../../../models/requests.dart';
import '../../../../network/system_api_service.dart';
import '../../../../preferences.dart';

class PaymentViewModel extends BaseViewModel {


  bool status = false;
  int pageIndex = 3;
  CardListResponse? cardListResponse;

  getCardListResponse(BuildContext context){
    cardListResponse = ModalRoute.of(context)!.settings.arguments as CardListResponse?;
    getAddressList(context, true);
  }

  getAddressList(BuildContext context, bool isShowProgress) async{
    if(isShowProgress){
      setBusy(true);
    }
    final userId = await Preferences.getKey(Preferences.kUserId);
    final resp = await SystemApiService.addressList(userId!);
    if (resp.isSuccess) {
      AppConfig.addressList.clear();
      AppConfig.addressList.addAll(resp.data!);
      bool isAddressIdMatch = false;
      for(int i = 0; i <  AppConfig.addressList.length; i++){
        if(AppConfig.addressList[i].title == AppConfig.deliveryAddress){
          AppConfig.addressId = AppConfig.addressList[i].id;
          isAddressIdMatch = true;
          break;
        }
      }

      if(isAddressIdMatch){
        setBusy(false);
        notifyListeners();
      }
      else{
        addNewAddress(context);
      }

    } else {
      setBusy(false);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Unknown error. Please try again later',
          onConfirmClick: () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }

  }


  addNewAddress(BuildContext context) async {
    final userId = await Preferences.getKey(Preferences.kUserId);
    final req = await makeAddNewAddressRequest(userId: userId!, lat: AppConfig.latitude.toString(),
        long: AppConfig.longitude.toString(),
        streetAddress: AppConfig.deliveryAddress, title: AppConfig.deliveryAddress);
    final resp = await SystemApiService.addNewAddress(req);
    if (resp.isSuccess) {
      getAddressList(context, false);
    } else {
      setBusy(false);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Unknown error. Please try again later',
          onConfirmClick: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
    }

  }

  onClickPlaceOrder(BuildContext context) async{
    if(cardListResponse == null){
      showAlert(context, title: '', message: 'Please Select Payment method');
      return;
    }

    showProgress(context);

    final userId = await Preferences.getKey(Preferences.kUserId);
    String preperId = AppConfig.menuResponseList[0].preperId.toString();
    String cartId = cardListResponse!.id.toString();
    List<OrdersItemList> orderItemList = [];
    for(int i = 0; i < AppConfig.menuResponseList.length; i++){
      orderItemList.add(OrdersItemList(AppConfig.menuResponseList[i].id!, AppConfig.menuResponseList[i].totalItems));
    }

    final req = await makePayWithStripeRequest(userId: userId!, preperId: preperId,
        amount: AppConfig.total.toString(), currency: AppConfig.PAYMENT_TYPE, cardId: cartId);

    // print('=======================${AppConfig.total.toString()}');
    // print('=======================cartId $cartId');
    // print('=======================preperId $preperId');
    // print('=======================userId $userId');

    final resp = await SystemApiService.payWithStripe(req);
    if (resp.isSuccess) {
      PayStripeResp payStripeResp = resp.data!;
      callPlaceOrder(context, userId, preperId, orderItemList, payStripeResp.transactionId.toString());
    } else {
      hideProgress(context);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Unknown error. please try again',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }

  callPlaceOrder(BuildContext context, String userId, String preperId,
      List<OrdersItemList> orderItemList, String transactionId) async{
    final req = await makePlaceOrderRequest(userId: userId, preperId: preperId,
        addressId: AppConfig.addressId.toString(), method: AppConfig.deliveryMethod, pickupDeliveryDate: AppConfig.pickupDeliveryDate,
        itemList: orderItemList, startTime: AppConfig.menuResponseList[0].resTiming!.startTime,
    endTime: AppConfig.menuResponseList[0].resTiming!.endTime, tax: getTaxAmount().toString(),
        transactionId: transactionId);
    // print('================userid : $userId\n'
    //     'prepeersId : $preperId\n'
    //     'addressId : ${AppConfig.addressId.toString()}\n'
    //     'method : ${AppConfig.deliveryMethod}\n'
    //     'transactionId : $transactionId\n'
    //     '${orderItemList[0].id}'
    //     '========');
    final resp = await SystemApiService.placeOrder(req);
    if (resp.isSuccess) {
      hideProgress(context);
      String time = 'from ${AppConfig.menuResponseList[0].resTiming!.startTime} to '
      '${AppConfig.menuResponseList[0].resTiming!.endTime}';
      AppConfig.menuResponseList.clear();
      Navigator.pushReplacementNamed(context, '/order_place_successfully_screen', arguments: time);
    } else {
      hideProgress(context);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Unknown error. please try again',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }

  double getTaxAmount(){
    return AppConfig.subTotal * AppConfig.salesTax / 100;
  }

  onClickAddPaymentMethod(BuildContext context){
    Navigator.pushReplacementNamed(context, '/payment_method_screen', arguments: 'PaymentScreen');
  }

  onClickEditDeliveryAddress(BuildContext context){
    Navigator.pushNamed(context, '/address_list_screen', arguments: 'PaymentScreen')
        .then((value) => value != null ? _getRequests():null);
  }

  _getRequests()async{
    notifyListeners();
  }

}
