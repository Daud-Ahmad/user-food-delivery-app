import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../components/alerts.dart';
import '../../../components/authentication.dart';
import '../../../config.dart';
import '../../../models/requests.dart';
import '../../../network/api_client.dart';
import '../../../network/system_api_service.dart';
import '../../../preferences.dart';

class SignupViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  bool passwordVisible = false;
  String? name = '';
  String? email = '';
  String? phone = '';
  String? password = '';
  bool isSignupButtonEnable = true;

  togglePassword() {
    passwordVisible = !passwordVisible;
    formKey.currentState!.save();
    notifyListeners();
  }

  toggleDialogPassword() {
    passwordVisible = !passwordVisible;
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
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
      return 'Phone Number is required';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  inputName(String? value) {
    name = value!.trim();
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

  inputPassword(String? value) {
    password = value!.trim();
    notifyListeners();
  }

  onForgotPassword(context) {
    Navigator.pushNamed(context, '/forgot_password');
  }

  onSignupButtonClick(context) async {
      formKey.currentState!.save();

      if (formKey.currentState == null) {
        return;
      }

      if (!formKey.currentState!.validate()) {
        return;
      }
      onSignup(context);
  }

  onSignIn(BuildContext context)
  {
    Navigator.pop(context);
  }

  onSignup(BuildContext context) async {
    if(isSignupButtonEnable){
      setBusy(true);
      isSignupButtonEnable = false;
      final req = await makeSignUpRequest(name: name!, phone: phone!, email: email!, password: password!,
          token: AppConfig.token);
      final resp = await SystemApiService.signUp(req);
      if (resp.isSuccess) {
        var completeToken = 'Bearer ${resp.token!}';
        ApiClient.setAuthToken(completeToken);
        emailOtpCall(context, resp.data!.id.toString(), resp.data!.otp.toString(), completeToken);
      } else {
        setBusy(false);
        isSignupButtonEnable = true;
        showErrorAlert(context,
            title: 'Signup Failed',
            message: resp.message ?? resp.error ?? 'Getting error, please try again',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }
    }
  }

  emailOtpCall(BuildContext context, String userId, String otp, String authToken) async {
    final req = await makeEmailOtpRequest(userId: userId, otp: otp);
    final resp = await SystemApiService.verifyOtp(req);
    if (resp.isSuccess) {
      isSignupButtonEnable = true;
      await Preferences.setKey(Preferences.kToken, authToken);
      await Preferences.setKey(Preferences.kUserId, resp.data!.id.toString());
      await Preferences.setKey(Preferences.kUserName, resp.data!.name.toString());
      await Preferences.setKey(Preferences.kUserEmail, resp.data!.email.toString());
      await Preferences.setKey(Preferences.kUserPhone, resp.data!.phone.toString());
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home_screen', arguments: 0, (Route<dynamic> route) => false);
    } else {
      setBusy(false);
      isSignupButtonEnable = true;
      showErrorAlert(context,
          title: 'Signup Failed',
          message: resp.message ?? resp.error ?? 'Getting error, please try again',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }

  onContinueAsGuestClick(BuildContext context) async
  {
    await Preferences.setKey(Preferences.kIsUserAsGuest, "true");
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home_screen', (Route<dynamic> route) => false);
  }

  onClickGoogleLogin(BuildContext context){
    showProgress(context);
    // await Authentication.initializeFirebase(context: context);
    Authentication.onClickSignInWithGoogle(context: context);
  }
}
