import 'package:flutter/material.dart';
import 'package:mura_user_app/components/alerts.dart';
import 'package:stacked/stacked.dart';

import '../../../../models/requests.dart';
import '../../../../network/system_api_service.dart';
import '../../../../preferences.dart';

class ChangePasswordViewModel extends BaseViewModel {
  int pageIndex = 4;
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;
  String? oldPassword = '';
  String? newPassword = '';
  String? confirmPassword = '';

  bool isButtonEnable = true;

  toggleOldPassword() {
    oldPasswordVisible = !oldPasswordVisible;
    formKey.currentState!.save();
    notifyListeners();
  }

  toggleNewPassword() {
    newPasswordVisible = !newPasswordVisible;
    formKey.currentState!.save();
    notifyListeners();
  }

  toggleConfirmPassword() {
    confirmPasswordVisible = !confirmPasswordVisible;
    formKey.currentState!.save();
    notifyListeners();
  }

  inputOldPassword(String? value) {
    oldPassword = value!.trim();
    notifyListeners();
  }

  inputNewPassword(String? value) {
    newPassword = value!.trim();
    notifyListeners();
  }

  inputConfirmPassword(String? value) {
    confirmPassword = value!.trim();
    notifyListeners();
  }

  String? oldPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Old Password is required';
    }
    return null;
  }

  String? newPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'New Password is required';
    }
    return null;
  }

  String? confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    return null;
  }

  onSaveButtonClick(context) async {
      formKey.currentState!.save();

      if (formKey.currentState == null) {
        return;
      }

      if (!formKey.currentState!.validate()) {
        return;
      }

      if(newPassword != confirmPassword){
        showErrorAlert(context, title: '', message: 'New Password and Confirm Password must be match', onConfirmClick: (){
          Navigator.pop(context);
        });
        return;
      }

      if(isButtonEnable){
        setBusy(true);
        isButtonEnable = false;
        final id = await Preferences.getKey(Preferences.kUserId);
        final req = await makeChangePasswordRequest(userId: id!, oldPassword: oldPassword!, newPassword: newPassword!);
        final resp = await SystemApiService.changePassword(req);
        if (resp.isSuccess) {
          setBusy(false);
          showSuccessAlert(context, title: 'Password changed', message: 'Your password changed successfully',
              onConfirmClick: (){
                Navigator.pop(context);
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
