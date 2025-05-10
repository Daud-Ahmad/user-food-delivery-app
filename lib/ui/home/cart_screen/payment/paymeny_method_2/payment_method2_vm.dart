import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class PaymentMethod2ViewModel extends BaseViewModel {

  int applePay = 0;
  int creditCard = 0;
  int pageIndex = 3;

  onClickApply(BuildContext context){
    Navigator.pushNamed(context, '/credit_card_info_screen');
  }

}
