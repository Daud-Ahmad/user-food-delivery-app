import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../components/alerts.dart';
import '../../../models/requests.dart';
import '../../../network/api_client.dart';
import '../../../network/system_api_service.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  bool passwordVisible = false;
  String? email = '';
  String? otpFromUser = '';
  bool isButtonEnable = true;
  bool isShowEmailView = true;
  bool isShowOtpView = false;
  bool isShowForgetPasswordView = false;

  int? userId;
  int? otp;


  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;

  String? newPassword = '';
  String? confirmPassword = '';

  togglePassword() {
    passwordVisible = !passwordVisible;
    formKey.currentState!.save();
    notifyListeners();
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? otpValidator(value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    return null;
  }

  inputEmail(String? value) {
    email = value!.trim();
    notifyListeners();
  }

  inputOtp(String? value) {
    otpFromUser = value!.trim();
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

  inputNewPassword(String? value) {
    newPassword = value!.trim();
    notifyListeners();
  }

  inputConfirmPassword(String? value) {
    confirmPassword = value!.trim();
    notifyListeners();
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

  onResetButtonClick(context) async {
    formKey.currentState!.save();

    if (formKey.currentState == null) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    onForgetPassword(context);
  }

  onForgetPassword(BuildContext context) async {
    if(isButtonEnable){
      setBusy(true);
      isButtonEnable = false;
      final req = await makeForgetPasswordRequest(email: email!);
      final resp = await SystemApiService.forgetPassword(req);
      if (resp.isSuccess) {
        isButtonEnable = true;
        var completeToken = 'Bearer ${resp.token!}';
        ApiClient.setAuthToken(completeToken);
        isShowEmailView = false;
        isShowOtpView = true;
        userId = resp.data!.id;
        otp = resp.data!.opt;
        setBusy(false);
        notifyListeners();
      } else {
        setBusy(false);
        isButtonEnable = true;
        showErrorAlert(context,
            title: 'Failed',
            message: resp.message ?? resp.error ?? 'Unknown Error',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }
    }

  }

  verifyOtp(BuildContext context){

    formKey.currentState!.save();

    if (formKey.currentState == null) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    if(otpFromUser == otp.toString()){
      isShowOtpView = false;
      isShowForgetPasswordView = true;
      notifyListeners();
    }
    else{
      showErrorAlert(context, title: "Invalid OTP", message: "Your OTP is not valid.", onConfirmClick: (){
        Navigator.pop(context);
      });
    }

  }

  onSetPassword(context) async {
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
      final req = await makeSetPasswordRequest(userId: userId.toString(), password: newPassword!);
      final resp = await SystemApiService.setPassword(req);
      if (resp.isSuccess) {
        setBusy(false);
        showSuccessAlert(context, title: 'Password changed', message: 'You can now sign in with your new password',
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
