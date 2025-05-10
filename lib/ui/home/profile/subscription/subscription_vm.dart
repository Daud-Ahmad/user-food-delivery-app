import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class SubscriptionViewModel extends BaseViewModel {
  int pageIndex = 4;

  String selectedChangeSchedule = 'Mon, 05 march 2021';

  List<String> changeScheduleList = ['Mon, 05 march 2021', 'Mon, 06 march 2021', 'Mon, 07 march 2021'];

  String selectedChangeQuantity = '2';

  List<String> changeQuantityList = ['2', '3', '4'];

  onClickOrders(BuildContext context){
    Navigator.pushNamed(context, '/orders_list_screen');
  }

  onClickSwitchProduct(BuildContext context){
    Navigator.pushNamed(context, '/restaurant_menu_screen');
  }
}
