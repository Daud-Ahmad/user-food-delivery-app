import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../components/alerts.dart';
import '../../../models/favourite_restaurant.dart';
import '../../../models/restaurant_list.dart';
import '../../../network/system_api_service.dart';
import '../../../preferences.dart';

class TabHomeFavouriteViewModel extends BaseViewModel {

  List<FavouriteRestaurant> favouriteRestaurant = [];

  onFavouriteListItemClick(BuildContext context, FavouriteRestaurant favouriteRestaurant){
    Restaurant restaurant = Restaurant(favouriteRestaurant.id,
        1, favouriteRestaurant.name, favouriteRestaurant.email,
        favouriteRestaurant.phone, favouriteRestaurant.profileImage,
        '', favouriteRestaurant.rating, favouriteRestaurant.totalReviews, favouriteRestaurant.resAddress, favouriteRestaurant.resTiming);
    Navigator.pushNamed(context, '/restaurant_detail_screen', arguments: restaurant);
  }

  gettingFavouriteRestaurantList(BuildContext context) async {
    setBusy(true);
    final userId = await Preferences.getKey(Preferences.kUserId);
    final resp = await SystemApiService.gettingFavouriteRestaurantsList(userId!);
    if (resp.isSuccess) {
      favouriteRestaurant.clear();
      favouriteRestaurant.addAll(resp.data!);
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
