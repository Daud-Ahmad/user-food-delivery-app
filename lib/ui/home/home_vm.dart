import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../components/show_login_bottom_sheet.dart';
import '../../preferences.dart';
import 'cart_screen/cart_vu.dart';
import 'favourite_screen/favourite_screen_vu.dart';
import 'home_screen/home_screen_vu.dart';
import 'orders/tab_orders_screen_vu.dart';
import 'profile/profile_screen_vu.dart';

class HomeViewModel extends BaseViewModel {

  int pageIndex = 0;
  List<Widget> tabs = [];

  getIndex(BuildContext context){
    int? index = ModalRoute.of(context)!.settings.arguments as int?;
    if(index != null){
      pageIndex = index;
    }
    getTabs();
  }

  getTabs() {

    tabs = [
      const TabHomeScreen(),
      const TabFavouriteScreen(),
      const TabOrdersScreen(),
      const CartScreen(),
      const TabProfileScreen(),
    ];

    return tabs;
  }

  onClickBottomTab(int index, BuildContext context) async{
    final token = await Preferences.getKey(Preferences.kToken);
    if(index == 1 || index == 2 || index == 4){
      if(token == null || token.isEmpty){
        showCLoginBottomSheet(context);
        return;
      }
    }
    pageIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
