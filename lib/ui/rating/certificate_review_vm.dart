import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../components/alerts.dart';
import '../../models/reviews.dart';
import '../../network/system_api_service.dart';

class CertificateReviewViewModel extends BaseViewModel {

  int? restaurantId;
  List<Reviews> reviewsList = [];

  getRestaurantId(BuildContext context){
    restaurantId = ModalRoute.of(context)!.settings.arguments as int;

    getReviewsList(context);
  }


  getReviewsList(BuildContext context) async {
    setBusy(true);
    final resp = await SystemApiService.reviewList(restaurantId.toString());
    if (resp.isSuccess) {
      reviewsList.clear();
      reviewsList.addAll(resp.data!);
      setBusy(false);
    } else {
      setBusy(false);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Error occurred while getting data',
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
        return rating;
      }
    }
  }

}
