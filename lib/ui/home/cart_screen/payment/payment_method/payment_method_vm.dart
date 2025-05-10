import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/alerts.dart';
import '../../../../../models/card_list_response.dart';
import '../../../../../network/system_api_service.dart';
import '../../../../../preferences.dart';

class PaymentMethodViewModel extends BaseViewModel {


  bool status = false;
  int pageIndex = 3;

  List<CardListResponse> cardList = [];

  String? screenName;

  getScreenName(BuildContext context){
    screenName = ModalRoute.of(context)!.settings.arguments as String?;
  }




  // onClickAddPaymentMethod(BuildContext context){
  //   Navigator.pushNamed(context, '/payment_method2_screen');
  // }
  //
  // onClickApply(BuildContext context){
  //   Navigator.pushNamed(context, '/credit_card_info_screen');
  // }
  //
  // onClickFiveSixSeven(BuildContext context){
  //   Navigator.pushNamed(context, '/change_payment_method_screen');
  // }

  getCardList(BuildContext? context) async{
    setBusy(true);
    final userId = await Preferences.getKey(Preferences.kUserId);
    final resp = await SystemApiService.cardList(userId!);
    if (resp.isSuccess) {
      cardList.clear();
      cardList.addAll(resp.data!);
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

  deleteCard(BuildContext context, int index) async{
    showProgress(context);
    final resp = await SystemApiService.deleteCard(cardList[index].id.toString());
    if (resp.isSuccess) {
      hideProgress(context);
      cardList.removeAt(index);
      showSuccessAlert(context, title: 'Card Deleted', message: 'Your Card Deleted Successfully',
          onConfirmClick: (){
        Navigator.pop(context);
        notifyListeners();
          });
    } else {
      hideProgress(context);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Error occurred while card deleting',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }

  }


  onClickAddPaymentMethod(BuildContext context){
    Navigator.pushNamed(context, '/credit_card_info_screen')
        .then((value) => value != null ? _getRequests():null);
  }

  onClickCartItem(BuildContext context, int index){
    if(screenName == null){
      Navigator.pushNamed(context, '/credit_card_info_screen', arguments: cardList[index])
          .then((value) => value != null ? _getRequests():null);
    }
    else{
      Navigator.pushReplacementNamed(context, '/payment_screen', arguments: cardList[index]);
    }
  }

  _getRequests()async{
    getCardList(null);
  }


}
