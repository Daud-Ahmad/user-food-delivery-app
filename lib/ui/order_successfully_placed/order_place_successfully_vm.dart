import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OrderPlaceSuccessfullyViewModel extends BaseViewModel {

  int pageIndex = 3;
  String time = '';

  onClickOrderDetail(BuildContext context){
    Navigator.pushNamed(context, '/order_detail_screen');
  }

  onClickTrackYourOrder(BuildContext context){
    Navigator.pushNamed(context, '/track_your_order_screen');
  }

  getData(BuildContext context){
    time = ModalRoute.of(context)!.settings.arguments as String;
    notifyListeners();
  }

}
