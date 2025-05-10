import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import '../../../config.dart';
import '../../../preferences.dart';

class CartViewModel extends BaseViewModel {

  int pageIndex = 3;

  bool isDelivery = true;

  String getRecentDateFromDay(){
    String recentDate = '';
    DateTime nowDate = DateTime.now();
    int todayDate = nowDate.day;
    int year = nowDate.year;
    int month = nowDate.month;
    DateTime thisMonth = DateTime(year, month, todayDate);
    for (int i = 1; i <= 7; i++) {
      var date = thisMonth.add(Duration(days: i));
      var dayName = DateFormat('EEE').format(date);
      if(AppConfig.menuResponseList[0].resTiming!.deliveryDay.toLowerCase() == dayName.toLowerCase()){
        var dayName = DateFormat('d MMM, yyyy, EEEE').format(date);
        AppConfig.pickupDeliveryDate = DateFormat('d-MM-yyyy').format(date);
        recentDate = dayName;
      }
    }
    return recentDate;
  }

  onClickDelivery(){
    if(!isDelivery){
      isDelivery = true;
      AppConfig.menuResponseList[0].deliveryFee = AppConfig.deliveryFee;
      calculateTotal();
      notifyListeners();
    }
  }

  onClickPickup(){
    if(isDelivery){
      isDelivery = false;
      AppConfig.menuResponseList[0].deliveryFee = 0.00;
      calculateTotal();
      notifyListeners();
    }
  }

  onClickContinue(BuildContext context){
    if(isDelivery){
      AppConfig.deliveryMethod = 'delivery';
    }
    else{
      AppConfig.deliveryMethod = 'pickup';
    }
    Navigator.pushNamed(context, '/payment_screen');
  }

  onClickLogin(BuildContext context) async{
    await Preferences.setKey(Preferences.kIsUserAsGuest, "");
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login_screen', (Route<dynamic> route) => false);
  }

  addOneItem(int index){
    AppConfig.menuResponseList[index].totalItems++;
    calculateSubTotal();
    calculateTotal();
    notifyListeners();
  }

  minusOneItem(int index){
    if(AppConfig.menuResponseList[index].totalItems > 0){
      AppConfig.menuResponseList[index].totalItems--;
      calculateSubTotal();
      calculateTotal();
    }
    else{
      AppConfig.menuResponseList.removeAt(index);
    }
    notifyListeners();
  }

  double calculateSubTotal(){
    AppConfig.subTotal = 0;
    AppConfig.total = 0;
    for(int i = 0; i< AppConfig.menuResponseList.length; i++){
      AppConfig.subTotal = AppConfig.subTotal + AppConfig.menuResponseList[i].getTotalPrice();
    }
    return AppConfig.subTotal;
  }

  double calculateTotal(){
    AppConfig.total = AppConfig.subTotal + AppConfig.menuResponseList[0].deliveryFee + AppConfig.discount + getTaxAmount();
    return AppConfig.total;
  }

  double getTaxAmount(){
    return AppConfig.subTotal * AppConfig.salesTax / 100;
  }

  String getCompleteDayName(String day){
    switch(day){
      case 'Sun' :
        return 'Sunday';
      case 'Mon' :
        return 'Monday';
      case 'Tue' :
        return 'Tuesday';
      case 'Wed' :
        return 'Wednesday';
      case 'Thu' :
        return 'Thursday';
      case 'Fri' :
        return 'Friday';
      case 'Sat' :
        return 'Saturday';
    }
    return 'Sunday';
  }

}
