import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../components/alerts.dart';
import '../../../network/system_api_service.dart';
import '../../../preferences.dart';

class ProfileScreenViewModel extends BaseViewModel {

  bool status = false;
  String? userName = '';

  getUserName() async{
    userName = await Preferences.getKey(Preferences.kUserName);
    notifyListeners();
  }

  onEditProfileClick(BuildContext context){
    Navigator.pushNamed(context, '/edit_profile_screen');
  }

  onChangePasswordClick(BuildContext context){
    Navigator.pushNamed(context, '/change_password_screen');
  }

  onSubscriptionClick(BuildContext context){
    Navigator.pushNamed(context, '/subscription_screen');
  }

  onNotificationClick(BuildContext context){
    Navigator.pushNamed(context, '/notifications_screen');
  }

  onClickContactUs(BuildContext context){
    Navigator.pushNamed(context, '/contact_us_screen');
  }

  onClickApply(BuildContext context){
    Navigator.pushNamed(context, '/payment_method_screen');
  }

  onClickMyAddress(BuildContext context){
    Navigator.pushNamed(context, '/address_list_screen');
  }

  onClickLogOut(BuildContext context) async{
    showConfirmationAlert(context, title: 'Logout', message: 'Are you sure you want to Logout?', onConfirmClick: () async{
      await Preferences.setKey(Preferences.kToken, "");
      await Preferences.setKey(Preferences.kIsUserAsGuest, "");
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login_screen', (Route<dynamic> route) => false);

    }, onCancelClick: (){
      Navigator.pop(context);
    }, confirmTitle: 'Logout');
  }

  onClickDeleteAccount(BuildContext context) async {
    showConfirmationAlert(context, title: 'Delete Account', message: 'Are you sure you want to Delete Account?',
        onConfirmClick: () async{
          Navigator.pop(context);
          showProgress(context);
          final userId = await Preferences.getKey(Preferences.kUserId);
          final resp = await SystemApiService.deleteAccount(userId!);
          if (resp.isSuccess) {
            await Preferences.setKey(Preferences.kToken, "");
            await Preferences.setKey(Preferences.kIsUserAsGuest, "");
            hideProgress(context);
            showSuccessAlert(context, title: 'Account deleted',
                message: 'Your account deleted successfully',
                onConfirmClick: () async{
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login_screen', (Route<dynamic> route) => false);
                });
          } else {
            hideProgress(context);
            showErrorAlert(context,
                title: 'Failed',
                message: resp.message ?? resp.error ?? 'Server error. Please try again',
                onConfirmClick: () {
                  Navigator.pop(context);
                });
          }
    }, onCancelClick: (){
      Navigator.pop(context);
    }, confirmTitle: 'Delete');
  }

}
