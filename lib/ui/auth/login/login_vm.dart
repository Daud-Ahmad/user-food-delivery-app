import 'package:flutter/material.dart';
import 'package:mura_user_app/config.dart';
import 'package:stacked/stacked.dart';

import '../../../components/alerts.dart';
import '../../../components/authentication.dart';
import '../../../models/requests.dart';
import '../../../network/api_client.dart';
import '../../../network/system_api_service.dart';
import '../../../preferences.dart';

class LoginViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  bool passwordVisible = false;
  String? email = '';
  String? password = '';
  bool isButtonEnable = true;

  togglePassword() {
    passwordVisible = !passwordVisible;
    formKey.currentState!.save();
    notifyListeners();
  }

  toggleDialogPassword() {
    passwordVisible = !passwordVisible;
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  inputPassword(String? value) {
    password = value!.trim();
    notifyListeners();
  }

  inputEmail(String? value) {
    email = value!.trim();
    notifyListeners();
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  onForgotPassword(context) {
    Navigator.pushNamed(context, '/reset_password_screen');
  }

  onLoginButtonClick(context) async {
      formKey.currentState!.save();

      if (formKey.currentState == null) {
        return;
      }

      if (!formKey.currentState!.validate()) {
        return;
      }
      onLogin(context);
    }

  onLogin(BuildContext context) async {
    if(isButtonEnable){
      setBusy(true);
      isButtonEnable = false;
      final req = await makeLoginRequest(email: email!, password: password!, token: AppConfig.token);
      final resp = await SystemApiService.login(req);
      if (resp.isSuccess) {
        var completeToken = 'Bearer ${resp.token!}';
        ApiClient.setAuthToken(completeToken);
        await Preferences.setKey(Preferences.kToken, completeToken);
        await Preferences.setKey(Preferences.kUserId, resp.data!.id.toString());
        await Preferences.setKey(Preferences.kUserName, resp.data!.name.toString());
        await Preferences.setKey(Preferences.kUserEmail, resp.data!.email.toString());
        await Preferences.setKey(Preferences.kUserPhone, resp.data!.phone.toString());
        Navigator.pushReplacementNamed(context, '/home_screen');
      } else {
        setBusy(false);
        isButtonEnable = true;
        showErrorAlert(context,
            title: 'Login Failed',
            message: resp.message ?? resp.error ?? 'email or password incorrect',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }
    }

  }

  onSignup(BuildContext context)
  {
    Navigator.pushNamed(context, '/signup_screen');
  }

  onContinueAsGuestClick(BuildContext context) async
  {
    await Preferences.setKey(Preferences.kIsUserAsGuest, "true");
    Navigator.pushReplacementNamed(context, '/home_screen');
  }

  onClickGoogleLogin(BuildContext context){
    showProgress(context);
    // await Authentication.initializeFirebase(context: context);
    Authentication.onClickSignInWithGoogle(context: context);
  }

  userBlockedDialog(BuildContext context){
    String? block = ModalRoute.of(context)!.settings.arguments as String?;
    if(block != null && block == 'blocked'){
      return Future.delayed(const Duration(microseconds: 700), () async {
        showErrorAlert(context, title: 'Your Account is blocked',
            message: 'Your account is blocked due to some reasons. please contact using this link\nhttps://muraapp.com/', onConfirmClick: (){
              Navigator.pop(context);
            });
      });
    }
  }

}
