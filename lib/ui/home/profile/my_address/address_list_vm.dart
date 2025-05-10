import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/alerts.dart';
import '../../../../../network/system_api_service.dart';
import '../../../../../preferences.dart';
import '../../../../config.dart';
import '../../../../models/requests.dart';

class AddressListViewModel extends BaseViewModel {

  bool status = false;
  int pageIndex = 4;

  Position? position;
  double? latitude;
  double? longitude;
  String? streetAddress;
  String? addressTitle;

  String? screenName;

  getScreenName(BuildContext context){
    screenName = ModalRoute.of(context)!.settings.arguments as String?;
  }

  getAddressList(BuildContext? context) async{
    setBusy(true);
    final userId = await Preferences.getKey(Preferences.kUserId);
    final resp = await SystemApiService.addressList(userId!);
    if (resp.isSuccess) {
      AppConfig.addressList.clear();
      AppConfig.addressList.addAll(resp.data!);
      setBusy(false);
    } else {
      setBusy(false);
      if(context != null){
        showErrorAlert(context,
            title: 'Error',
            message: resp.message ?? resp.error ?? 'Error occurred while getting card list',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }
    }

  }


  onClickAddNewAddress(BuildContext context){
    determinePosition(context);
  }

  Future<Position> determinePosition(BuildContext context) async {
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

    position = await Geolocator.getCurrentPosition();
    double lat = position!.latitude;
    double lng = position!.longitude;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => PlacePicker(
          apiKey: AppConfig.googleMapApiKey,
          onPlacePicked: (result) {
            latitude = result.geometry!.location.lat;
            longitude = result.geometry!.location.lng;
            streetAddress = result.formattedAddress;
            addressTitle = streetAddress;
            Navigator.of(context).pop();
            addNewAddress(context);
          },
          initialPosition: LatLng(lat, lng),
          useCurrentLocation: true,
          selectInitialPosition: true,
        ),
      ),
    );
    return position!;
  }


  addNewAddress(BuildContext context) async {
    showProgress(context);
      final userId = await Preferences.getKey(Preferences.kUserId);
      final req = await makeAddNewAddressRequest(userId: userId!, lat: latitude.toString(),
      long: longitude.toString(), streetAddress: streetAddress!, title: addressTitle!);
      final resp = await SystemApiService.addNewAddress(req);
      if (resp.isSuccess) {
        hideProgress(context);
        showSuccessAlert(context, title: 'Address Added',
            message: 'Your Address added successfully',
            onConfirmClick: (){
              Navigator.pop(context);
              getAddressList(context);
            });

      } else {
        hideProgress(context);
        showErrorAlert(context,
            title: 'Error',
            message: resp.message ?? resp.error ?? 'Error occurred while adding new address',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }

  }

  onClickSelect(BuildContext context, int index){
    AppConfig.addressId = AppConfig.addressList[index].id;
    AppConfig.latitude = double.parse(AppConfig.addressList[index].lat);
    AppConfig.longitude = double.parse(AppConfig.addressList[index].long);
    AppConfig.deliveryAddress = AppConfig.addressList[index].title;
    Navigator.pop(context, true);
  }


}
