import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/alerts.dart';
import '../../../../models/requests.dart';
import '../../../../network/system_api_service.dart';
import '../../../../preferences.dart';

class EditProfileViewModel extends BaseViewModel {
  int pageIndex = 4;
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  bool passwordVisible = false;
  String? username = '';
  String? email = '';
  String? phone = '';
  String? id;
  bool isButtonEnable = true;

  getProfileData() async{
    id = await Preferences.getKey(Preferences.kUserId);
    username = await Preferences.getKey(Preferences.kUserName);
    phone = await Preferences.getKey(Preferences.kUserPhone);
    email = await Preferences.getKey(Preferences.kUserEmail);
    notifyListeners();
  }

  String? usernameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? phoneValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    return null;
  }

  inputUsername(String? value) {
    username = value!.trim();
    notifyListeners();
  }

  inputEmail(String? value) {
    email = value!.trim();
    notifyListeners();
  }

  inputPhone(String? value) {
    phone = value!.trim();
    notifyListeners();
  }

  onEditProfile(BuildContext context) async {
    formKey.currentState!.save();
    if (formKey.currentState == null) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }
    if(isButtonEnable){
      setBusy(true);
      isButtonEnable = false;
      final req = await makeEditProfileRequest(userId: id!, name: username!, email: email!, phone: phone!);
      final resp = await SystemApiService.editProfile(req);
      if (resp.isSuccess) {
        isButtonEnable = true;
        await Preferences.setKey(Preferences.kUserName, username!);
        await Preferences.setKey(Preferences.kUserEmail, email!);
        await Preferences.setKey(Preferences.kUserPhone, phone!);
        setBusy(false);
      showSuccessAlert(context, title: 'Profile Edited', message: 'Your profile edit successfully',
          onConfirmClick: (){
        Navigator.pop(context);
          });
      } else {
        setBusy(false);
        isButtonEnable = true;
        showErrorAlert(context,
            title: 'Error',
            message: resp.message ?? resp.error ?? 'Something getting wrong',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }
    }

  }
}
