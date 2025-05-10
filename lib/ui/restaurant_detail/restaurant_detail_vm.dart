import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../components/alerts.dart';
import '../../components/show_login_bottom_sheet.dart';
import '../../models/menu_response.dart';
import '../../models/requests.dart';
import '../../models/restaurant_list.dart';
import '../../network/system_api_service.dart';
import '../../preferences.dart';

class RestaurantDetailViewModel extends BaseViewModel {

  int pageIndex = 0;
  bool hideView = false;

  Restaurant? restaurant;
  List<MenuResponse> menuResponseList = [];

  getRestaurant(BuildContext context){
    restaurant = ModalRoute.of(context)!.settings.arguments as Restaurant;
    if(restaurant != null && restaurant!.id != null){
      getMenuList(context, restaurant!.id.toString());
    }
    notifyListeners();
  }

  getMenuList(BuildContext context, String preppersId) async {
    setBusy(true);
    final resp = await SystemApiService.gettingMenuList(preppersId);
    if (resp.isSuccess) {
      menuResponseList.clear();
      if(resp.data != null){
        menuResponseList.addAll(resp.data!);
      }
      setBusy(false);
    } else {
      setBusy(false);
      showErrorAlert(context,
          title: 'Menu List Error',
          message: resp.message ?? resp.error ?? 'Error occurred while getting data',
          onConfirmClick: () {
        Navigator.pop(context);
      });
    }

  }

  onClickHeart(BuildContext context)async{
    final token = await Preferences.getKey(Preferences.kToken);
    if(token == null || token.isEmpty){
      showCLoginBottomSheet(context);
    }
    else{
      showProgress(context);
      final userId = await Preferences.getKey(Preferences.kUserId);
      final req = await makeLikeUnlikeResRequest(userId: userId!, prepperId: restaurant!.id.toString());
      String endPoint = '';
      if(restaurant!.liked == 0){
        endPoint = 'like-prepper';
      }
      else{
        endPoint = 'unlike-prepper';
      }
      final resp = await SystemApiService.likeUnlikePrepper(req, endPoint);
      if (resp.isSuccess) {
        hideProgress(context);
        String title = restaurant!.liked == 0 ?  'Restaurant Liked' : 'Restaurant Unliked';
        String message = restaurant!.liked == 0 ?  'Restaurant Liked Successfully' : 'Restaurant Unliked Successfully';
        restaurant!.liked == 1 ?  restaurant!.liked = 0 : restaurant!.liked = 1;
        notifyListeners();
        showSuccessAlert(context, title: title, message: message, onConfirmClick: (){
          Navigator.pop(context);
        });
      } else {
        hideProgress(context);
        showErrorAlert(context,
            title: 'Error',
            message: resp.message ?? resp.error ?? 'try again',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }

    }
  }

  onClickAddMenu(BuildContext context, MenuResponse menuResponse){
    menuResponse.restaurantName = restaurant!.name;
    if(restaurant!.resTiming != null){
      menuResponse.resTiming = restaurant!.resTiming;
    }
    Navigator.pushNamed(context, '/restaurant_menu_screen', arguments: menuResponse);
  }

  onClickLogin(BuildContext context){
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login_screen', (Route<dynamic> route) => false);
  }

  String getRating(){
    if(restaurant == null ||restaurant!.rating == null){
      return '0.0';
    }
    else{
      if(restaurant!.rating.toString().length == 1){
        return '${restaurant!.rating}.0';
      }
      else{
        return appToStringAsFixed(restaurant!.rating.toString(), 1);
      }
    }
  }

  String appToStringAsFixed(String number, int afterDecimal) {
    return '${number.split('.')[0]}.${number.toString().split('.')[1].substring(0,afterDecimal)}';
  }

  onClickCertificateAndReview(BuildContext context){
    Navigator.pushNamed(context, '/certificate_review_screen', arguments: restaurant!.id);
  }

}
