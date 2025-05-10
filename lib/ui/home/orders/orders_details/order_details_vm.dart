import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/alerts.dart';
import '../../../../models/orders_detail_resp.dart';
import '../../../../network/system_api_service.dart';

class OrderDetailsViewModel extends BaseViewModel {
  int pageIndex = 2;
  int? ordersId;
  OrderDetailResp? orderDetailResp;

  getOrdersId(BuildContext context){
    ordersId = ModalRoute.of(context)!.settings.arguments as int?;
    gettingOrdersDetail(context);
  }


  gettingOrdersDetail(BuildContext context) async {
    setBusy(true);
    final resp = await SystemApiService.userOrdersDetail(ordersId.toString());
    if (resp.isSuccess) {
      orderDetailResp = resp.data;
      setBusy(false);
    } else {
      setBusy(false);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Error occurred while getting data',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }

  double getTotalAmount(){
    double totalAmount = 0.00;
    totalAmount = double.parse(orderDetailResp!.amount) + double.parse(orderDetailResp!.tax);
    if(orderDetailResp!.deliveryCharge != null){
      totalAmount = totalAmount + double.parse(orderDetailResp!.deliveryCharge);
    }

    return totalAmount;
  }

  double getSubTotalAmount(){
    double subTotalAmount = 0.00;
    for(int i = 0; i < orderDetailResp!.itemDetailsList!.length; i++){
      subTotalAmount = subTotalAmount +
          (double.parse(orderDetailResp!.itemDetailsList![i].itemDetailsList![0].price) *
              int.parse(orderDetailResp!.itemDetailsList![i].qty));
    }
    return subTotalAmount;
  }
}
