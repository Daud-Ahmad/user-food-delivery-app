import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../components/alerts.dart';
import '../../../config.dart';
import '../../../models/menu_type.dart';
import '../../../models/requests.dart';
import '../../../models/restaurant_list.dart';
import '../../../network/system_api_service.dart';
import '../../../preferences.dart';

class HomeRestaurantListViewModel extends BaseViewModel {
  int pageIndex = 0;
  List<Restaurant> nearYouRestaurantsList = [];
  List<Restaurant> popularRestaurantsList = [];
  List<MenuType> menuTypeList = [];

  getMenuTypeList(BuildContext context){
    menuTypeList.clear();
    menuTypeList.addAll(ModalRoute.of(context)!.settings.arguments as List<MenuType>);
    for(int i = 0; i < menuTypeList.length; i++){
      if(menuTypeList[i].isSelected){
        gettingRestaurantList(context, menuTypeList[i].id.toString());
      }
    }
  }

  onClickRestaurantDetail(BuildContext context, Restaurant restaurant){
    Navigator.pushNamed(context, '/restaurant_detail_screen', arguments: restaurant);
  }

  onFilterClick(BuildContext context){
    Navigator.pushNamed(context, '/home_restaurant_filter_screen');
  }

  onClickMenuTypeListItem(BuildContext context, int index){
    for(int i = 0; i < menuTypeList.length; i++){
      menuTypeList[i].isSelected = false;
    }
    menuTypeList[index].isSelected = true;
    notifyListeners();
    gettingRestaurantList(context, menuTypeList[index].id.toString());
  }

  gettingRestaurantList(BuildContext context, String typeId) async {
    setBusy(true);
    final userId = await Preferences.getKey(Preferences.kUserId);
    final req = await makeRestaurantsListRequest(typeId: typeId, lat: AppConfig.latitude.toString(),
        long: AppConfig.longitude.toString(), userId: userId);
    final resp = await SystemApiService.gettingRestaurantsList(req);
    if (resp.isSuccess) {
      nearYouRestaurantsList.clear();
      popularRestaurantsList.clear();
      nearYouRestaurantsList.addAll(resp.data!.nearYouRestaurants!);
      popularRestaurantsList.addAll(resp.data!.popularRestaurants!);
      setBusy(false);
    } else {
      setBusy(false);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Error occurred while getting data ',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }

  String getRating(dynamic rating){
    if(rating == null){
      return '0.0';
    }
    else{
      if(rating.toString().length == 1){
        return '$rating.0';
      }
      else{
        return appToStringAsFixed(rating.toString(), 1);
      }
    }
  }

  String appToStringAsFixed(String number, int afterDecimal) {
    return '${number.split('.')[0]}.${number.toString().split('.')[1].substring(0,afterDecimal)}';
  }
}
