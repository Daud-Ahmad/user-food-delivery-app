import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:mura_user_app/models/orders_list_resp.dart';
import 'package:stacked/stacked.dart';

import '../../../components/alerts.dart';
import '../../../config.dart';
import '../../../models/menu_type.dart';
import '../../../network/system_api_service.dart';
import '../../../preferences.dart';

class TabHomeScreenViewModel extends BaseViewModel {
  bool isShowAddAddressView = false;
  List<MenuType> menuTypeList = [];

  String greetingText = '';

  onClickCurrentLocation(){
    isShowAddAddressView = true;
    notifyListeners();
  }

  startScreenGettingData(BuildContext context){
    DateTime now = DateTime.now();
    int minute = now.hour;
    setGreetingText(minute);
    if(AppConfig.latitude == null || AppConfig.longitude == null){
      determinePosition(context, true);
    }
    else{
      gettingMenuList(context, true);
    }
  }

  onClickOrderNow(BuildContext context, int index){
    for(int i = 0; i < menuTypeList.length; i++){
      menuTypeList[i].isSelected = false;
    }
    menuTypeList[index].isSelected = true;
    Navigator.pushNamed(context, '/home_restaurant_list_screen', arguments: menuTypeList);
  }

  onClickCancel(){
    isShowAddAddressView = false;
    notifyListeners();
  }

  gettingMenuList(BuildContext context, bool isSetBustTrue) async {
    if(isSetBustTrue){
      setBusy(true);
    }
      final resp = await SystemApiService.gettingMenuTypeList();
      if (resp.isSuccess) {
        menuTypeList.clear();
        menuTypeList.addAll(resp.data!);
        final token = await Preferences.getKey(Preferences.kToken);
        if(token != null && AppConfig.isFirstTimeAppOpen){
          AppConfig.isFirstTimeAppOpen = false;
          checkOrderReviewedOrNot(context);
        }
        else{
          setBusy(false);
        }
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


  checkOrderReviewedOrNot(BuildContext context) async {
    final userId = await Preferences.getKey(Preferences.kUserId);
    final resp = await SystemApiService.checkOrderReviewedOrNot(userId!);
    if (resp.isSuccess) {
      setBusy(false);
      try{
        OrdersListResp ordersListResp = resp.data!;
        Navigator.pushNamed(context, '/get_rating_screen', arguments: ordersListResp);
      }catch(e){}
    } else {
      setBusy(false);
    }
  }

  gettingTax(BuildContext context, bool isSetBustTrue) async {
    if(isSetBustTrue){
      setBusy(true);
    }
    final userId = await Preferences.getKey(Preferences.kUserId);
    final resp = await SystemApiService.taxCharges(userId!);
    if (resp.isSuccess) {
      if(resp.data!.userStatus != null && resp.data!.userStatus.toString() == AppConfig.blockedUserValue)
        {
          await Preferences.setKey(Preferences.kToken, "");
          await Preferences.setKey(Preferences.kIsUserAsGuest, "");
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login_screen', arguments: 'blocked', (Route<dynamic> route) => false);
        }
      else{
        await Preferences.setKey(Preferences.kDeliveryFee, resp.data!.deliveryCharges);
        AppConfig.deliveryFee = double.parse(resp.data!.deliveryCharges);
        AppConfig.salesTax = double.parse(resp.data!.taxAmount);
        gettingMenuList(context, false);
      }
    } else {
      gettingMenuList(context, false);
    }
  }

  Future<Position> determinePosition(BuildContext context,
      bool isCallGettingTex) async {
    if(isCallGettingTex){
      setBusy(true);
    }
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition();
    AppConfig.latitude = position.latitude;
    AppConfig.longitude = position.longitude;

    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(AppConfig.latitude!, AppConfig.longitude!);

      AppConfig.deliveryAddress = '${placemarks[0].subLocality},'
          ' ${placemarks[0].subAdministrativeArea}';
    }
    catch(e){

    }
    if(isCallGettingTex){
      gettingTax(context, false);
    }
    else{
      isShowAddAddressView = false;
      notifyListeners();
    }
    return position;
  }

  onClickAddNewAddress(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: AppConfig.googleMapApiKey,
          onPlacePicked: (result) {
            AppConfig.latitude = result.geometry!.location.lat;
            AppConfig.longitude = result.geometry!.location.lng;
            AppConfig.deliveryAddress = result.formattedAddress!;
            Navigator.of(context).pop();
            isShowAddAddressView = false;
            notifyListeners();
          },
          initialPosition: LatLng(AppConfig.latitude!, AppConfig.longitude!),
          useCurrentLocation: true,
          selectInitialPosition: true,
        ),
      ),
    );
  }

  setGreetingText(int hours){
    if(hours >= 5 && hours <= 12){
      greetingText = 'Good morning,';
    }
    else if(hours > 12 && hours <= 18){
      greetingText = 'Good afternoon,';
    }
    else{
      greetingText = 'Good evening,';
    }
  }

}
