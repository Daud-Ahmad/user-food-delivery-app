import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../components/alerts.dart';
import '../../config.dart';
import '../../models/menu_detail_response.dart';
import '../../models/menu_response.dart';
import '../../network/system_api_service.dart';
import '../../preferences.dart';

class RestaurantMenuViewModel extends BaseViewModel {
  int pageIndex = 0;
  int totalItems = 0;
  int totalPrice = 0;
  int oneItemPrice = 0;

  MenuResponse? menuResponse;
  MenuDetailResponse? menuDetailResponse;

  getRestaurantMenu(BuildContext context){
    bool isItemAlreadyInCart = false;
    menuResponse = ModalRoute.of(context)!.settings.arguments as MenuResponse;
    try{
      for(int i = 0; i < AppConfig.menuResponseList.length; i++){
        if(menuResponse!.id == AppConfig.menuResponseList[i].id){
          isItemAlreadyInCart = true;
          totalItems = AppConfig.menuResponseList[i].totalItems;
          oneItemPrice = int.parse(AppConfig.menuResponseList[i].price);
          totalPrice = oneItemPrice * totalItems;
          break;
        }
      }
      if(!isItemAlreadyInCart){
        oneItemPrice = int.parse(menuResponse!.price);
        totalPrice = oneItemPrice;
        totalItems = 1;
      }
    }
    catch(e){}
    menuDetail(context, menuResponse!.id.toString());
    notifyListeners();
  }


  menuDetail(BuildContext context, String menuId) async {
    setBusy(true);
    final resp = await SystemApiService.menuDetail(menuId);
    if (resp.isSuccess) {
      menuDetailResponse = resp.data;
      setBusy(false);
    } else {
      setBusy(false);
      showErrorAlert(context,
          title: 'Menu Detail Error',
          message: resp.message ?? resp.error ?? 'Error occurred while getting data',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }

  }

  addItem(){
    totalItems++;
    totalPrice = totalPrice + oneItemPrice;
    notifyListeners();
  }

  minusItem(){
    if(totalItems > 0){
      totalItems--;
      totalPrice = totalPrice - oneItemPrice;
      notifyListeners();
    }
  }

  onClickAddToCart(BuildContext context) async{
    if(totalItems > 0){
      bool isNewResItem = false;
      String restaurantName = '';
      for(int i = 0; i < AppConfig.menuResponseList.length; i++){
        if(menuResponse!.preperId != AppConfig.menuResponseList[i].preperId){
          isNewResItem = true;
          restaurantName = AppConfig.menuResponseList[i].restaurantName;
          break;
        }
      }
      if(isNewResItem){
        showConfirmationAlert(context, title: 'Start new basket',
            message: 'Your basket already contains an item from $restaurantName. Would you like to clear the basket and add this item from ${menuResponse!.restaurantName} instead?',
        confirmTitle: 'NEW BASKIT', cancelTitle: 'CANCEL', onConfirmClick: (){
              Navigator.pop(context);
              AppConfig.menuResponseList.clear();
              onClickAddToCart(context);
            }, onCancelClick: (){
              Navigator.pop(context);
            });
        return;
      }
      bool isItemAlreadyInCart = false;
      for(int i = 0; i < AppConfig.menuResponseList.length; i++){
        if(menuResponse!.id == AppConfig.menuResponseList[i].id){
          AppConfig.menuResponseList[i].totalItems = totalItems;
          isItemAlreadyInCart = true;
          break;
        }
      }
      if(!isItemAlreadyInCart){
        menuResponse!.totalItems = totalItems;
        // await Preferences.saveUserProfile(menuResponse!);
        menuResponse!.deliveryFee = AppConfig.deliveryFee;
        AppConfig.menuResponseList.add(menuResponse!);
      }
      showSuccessAlert(context, title: 'Item Added', message: 'Item Added to Cart', onConfirmClick: (){
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
    else{
      showAlert(context, title: 'Add item first', message: 'You have 0 item. Minimum 1 item need for add to card');
    }
  }
}
