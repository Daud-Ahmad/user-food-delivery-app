import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config.dart';
import '../models/requests.dart';
import '../network/api_client.dart';
import '../network/system_api_service.dart';
import '../preferences.dart';
import 'alerts.dart';

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          hideProgress(context);
          showErrorAlert(context,
              title: 'Login Failed',
              message: 'Login Failed. please try again or user another login method',
              onConfirmClick: () {
                Navigator.pop(context);
              });
        }
        else if (e.code == 'invalid-credential') {
          hideProgress(context);
          showErrorAlert(context,
              title: 'Login Failed',
              message: 'Login Failed. please try again or user another login method',
              onConfirmClick: () {
                Navigator.pop(context);
              });
        }
      } catch (e) {
        hideProgress(context);
        showErrorAlert(context,
            title: 'Login Failed',
            message: 'Login Failed. please try again or user another login method',
            onConfirmClick: () {
              Navigator.pop(context);
            });
      }
    }

    return user;
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // socialLogin(context, user.displayName!, user.email!);
    }
    else{
      // hideProgress(context);
      // showErrorAlert(context,
      //     title: 'Login Failed',
      //     message: 'Login Failed. please try again or user another login method',
      //     onConfirmClick: () {
      //       Navigator.pop(context);
      //     });
    }

    return firebaseApp;
  }

  static onClickSignInWithGoogle({
    required BuildContext context,
  }) async {
    User? user =
    await Authentication.signInWithGoogle(context: context);
    if (user != null) {
      socialLogin(context, user.displayName!, user.email!, user.uid, null, null);
    }
    else{
      hideProgress(context);
      showErrorAlert(context,
          title: 'Login Failed',
          message: 'Login Failed. please try again or user another login method',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }

  static socialLogin(BuildContext context, String name, String email, String? googleId,
      String? appleId, String? facebookId) async{
    DateTime time = DateTime.now();
    int phone = time.millisecondsSinceEpoch;
    final req = await makeSocialLoginRequest(name: name, email: email,
      google: googleId, facebook: facebookId, apple: appleId, phone: phone.toString(),
        token: AppConfig.token);
    final resp = await SystemApiService.socialLogin(req);
    if (resp.isSuccess) {
      var completeToken = 'Bearer ${resp.token!}';
      ApiClient.setAuthToken(completeToken);
      await Preferences.setKey(Preferences.kToken, completeToken);
      await Preferences.setKey(Preferences.kUserId, resp.data!.id.toString());
      await Preferences.setKey(Preferences.kUserName, resp.data!.name.toString());
      await Preferences.setKey(Preferences.kUserEmail, resp.data!.email.toString());
      await Preferences.setKey(Preferences.kUserPhone, resp.data!.phone.toString());
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home_screen', (Route<dynamic> route) => false);
    } else {
      hideProgress(context);
      showErrorAlert(context,
          title: 'Login Failed',
          message: resp.message ?? resp.error ?? 'Login Failed. please try again or user another login method',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }
}