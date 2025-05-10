import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class OrdersListViewModel extends BaseViewModel {

  int pageIndex = 0;

  String selectedChangeSchedule = 'Mon, 05 march 2021';

  List<String> changeScheduleList = ['Mon, 05 march 2021', 'Mon, 06 march 2021', 'Mon, 07 march 2021'];

  String selectedChangeQuantity = '2';

  List<String> changeQuantityList = ['2', '3', '4'];

  onClickHelpAndSport(BuildContext context){
    Navigator.pushNamed(context, '/help_and_sport_screen');
  }
}
