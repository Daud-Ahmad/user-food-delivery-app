import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/alerts.dart';
import '../../../../../models/card_list_response.dart';
import '../../../../../models/requests.dart';
import '../../../../../network/system_api_service.dart';
import '../../../../../preferences.dart';
import '../../../../../styles.dart';

class CreditCardInfoViewModel extends BaseViewModel {

  int pageIndex = 3;
  final formKey = GlobalKey<FormState>();

  bool isButtonEnable = true;

  CardListResponse? cardListResponse;

  String? cardNumber = '';
  String? cvc = '';
  String? expiry = '';

  getCartInfo(BuildContext context){
    cardListResponse = ModalRoute.of(context)!.settings.arguments as CardListResponse?;
    if(cardListResponse != null){
      cardNumber = cardListResponse!.cardNumber;
      cvc = cardListResponse!.cvc;
      expiry = '${cardListResponse!.expMonth}/${cardListResponse!.expYear}';
      notifyListeners();
    }
  }

  inputCardNumber(String? value) {
    cardNumber = value!.trim();
  }

  inputCvc(String? value) {
    cvc = value!.trim();
  }

  inputExpiry(String? value) {
    expiry = value!.trim();
  }

  onClickSave(BuildContext context) async {
    formKey.currentState!.save();

    String message = '';
    bool isAllFieldsFilled = true;

    if(cardNumber!.isEmpty){
      message = 'Please enter card number';
      isAllFieldsFilled = false;
    }
    else if(cvc!.isEmpty){
      message = 'Please enter CVC';
      isAllFieldsFilled = false;
    }
    else if(expiry!.isEmpty){
      message = 'Please enter card expiry date';
      isAllFieldsFilled = false;
    }

    if(!isAllFieldsFilled){
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: cButtonColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    String month = '';
    String year = '';

    try{

      final monthYear = expiry!.split('/');
      month = monthYear[0];
      year = monthYear[1];
    }
    catch(e){
          showErrorAlert(context,
              title: 'Error',
              message: 'Expiry format should mm/yyyy',
              onConfirmClick: () {
                Navigator.pop(context);
              });
          return;
    }

    if(isButtonEnable){
      setBusy(true);
      isButtonEnable = false;
      final userId = await Preferences.getKey(Preferences.kUserId);
      final req = await makeAddNewCardRequest(userId: cardListResponse == null ? userId! : null,
          cardNumber: cardNumber!, expMonth: month, expYear: year, cvc: cvc!, cardId: cardListResponse != null ? cardListResponse!.id.toString() : null);
      final resp = await SystemApiService.addEditCard(req, cardListResponse == null ? 'add-card' : 'edit-card');
      if (resp.isSuccess) {
        showSuccessAlert(context, title: cardListResponse == null ? 'Card Add' : 'Card Edit',
            message: cardListResponse == null ? 'Your Card add successfully' : 'Your Card Edit successfully',
            onConfirmClick: (){
          Navigator.pop(context);
          Navigator.pop(context, true);
        });
      } else {
        setBusy(false);
        isButtonEnable = true;
        showErrorAlert(context,
            title: 'Error',
            message: resp.message ?? resp.error ?? 'Error occurred while adding card',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }
    }

  }

}
