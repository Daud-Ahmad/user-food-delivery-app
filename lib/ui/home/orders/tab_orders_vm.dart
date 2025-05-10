import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../components/alerts.dart';
import '../../../config.dart';
import '../../../models/orders_list_resp.dart';
import '../../../network/system_api_service.dart';
import '../../../preferences.dart';

class TabOrdersViewModel extends BaseViewModel {

  bool pendingOrders = true;
  bool activeOrders = false;
  bool cancelsOrders = false;
  bool completedOrders = false;

  String deliveryText = 'Delivery Date';

  String orderType = AppConfig.PENDING_ORDERS;

  List<OrdersListResp> ordersList = [];

  onActiveOrdersClick(BuildContext context){
    if(activeOrders){
      return;
    }
    deliveryText = 'Delivery Date';
    activeOrders = true;
    pendingOrders = false;
    cancelsOrders = false;
    completedOrders = false;
    orderType = AppConfig.ACTIVE_ORDERS;
    gettingOrdersList(context);
  }

   onPendingOrdersClick(BuildContext context){
    if(pendingOrders){
      return;
    }
    deliveryText = 'Delivery Date';
    pendingOrders = true;
    activeOrders = false;
    cancelsOrders = false;
    completedOrders = false;
    orderType = AppConfig.PENDING_ORDERS;
    gettingOrdersList(context);
  }

  onCancelsOrdersClick(BuildContext context){
    if(cancelsOrders){
      return;
    }
    deliveryText = 'Delivery Date';
    cancelsOrders = true;
    pendingOrders = false;
    activeOrders = false;
    completedOrders = false;
    orderType = AppConfig.CANCEL_ORDERS;
    gettingOrdersList(context);
  }

  onCompletedOrdersClick(BuildContext context){
    if(completedOrders){
      return;
    }
    deliveryText = 'Delivered';
    completedOrders = true;
    pendingOrders = false;
    cancelsOrders = false;
    activeOrders = false;
    orderType = AppConfig.COMPLETED_ORDERS;
    gettingOrdersList(context);
  }

  onClickOrderDetail(BuildContext context, int index){
    Navigator.pushNamed(context, '/order_detail_screen',
    arguments: ordersList[index].id);
  }

  gettingOrdersList(BuildContext context) async {
    setBusy(true);
    final userId = await Preferences.getKey(Preferences.kUserId);
    final resp = await SystemApiService.userOrders(orderType, userId!);
    if (resp.isSuccess) {
      ordersList.clear();
      ordersList.addAll(resp.data!);
      notifyListeners();
      setBusy(false);
    } else {
      setBusy(false);
      ordersList.clear();
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Error occurred while getting data',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }

  String ordersMenu(int index){
    List<OrdersItems> ordersItemsList = ordersList[index].itemDetailsList!;
    String menuDetail = '';
    for(int i = 0; i < ordersItemsList.length; i++){
      if(i == 0){
        menuDetail = '${ordersItemsList[i].itemDetailsList![0].title}    (${ordersItemsList[i].qty})';
      }
      else{
        menuDetail = '$menuDetail, ${ordersItemsList[i].itemDetailsList![0].title}    (${ordersItemsList[i].qty})';
      }
    }
    return menuDetail;
  }

}
