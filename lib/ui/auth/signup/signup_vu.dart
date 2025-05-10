import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';

import '../../../components/authentication.dart';
import '../../../components/raised_gradient_button.dart';
import '../../../styles.dart';
import 'signup_vm.dart';

class SignupScreen extends ViewModelBuilderWidget<SignupViewModel> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, SignupViewModel viewModel, Widget? child) {
    return PlatformScaffold(
      backgroundColor: Colors.white,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: viewModel.formKey,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 5.0),

                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text('Sign Up',
                    style: TextStyle(fontSize: 20,),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [

                        const Text("Already have an account?",
                          style: TextStyle(
                              color: cBlack50,
                              fontSize: 13
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            viewModel.onSignIn(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                            child: Text("Sign in",
                              style: TextStyle(
                                  color: cButtonColor,
                                  fontSize: 13
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),

                  TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.name,
                    decoration: InputStyles.getAuthInput(
                        hint: 'Name'),
                    validator: viewModel.nameValidator,
                    onSaved: (String? value) {
                      viewModel.inputName(value);
                    },
                    controller: TextEditingController(text: viewModel.name),
                    style: const TextStyle(color: Colors.black),

                  ),
                  const SizedBox(height: 20.0),

                  TextFormField(
                    cursorColor: Colors.black,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' ')
                    ],
                    decoration: InputStyles.getAuthInput(
                        hint: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: viewModel.emailValidator,
                    onSaved: (String? value) {
                      viewModel.inputEmail(value);
                    },
                    // initialValue: viewModel.username,
                    controller: TextEditingController(text: viewModel.email),
                    style: const TextStyle(color: Colors.black),

                  ),
                  const SizedBox(height: 20.0),

                  TextFormField(
                    cursorColor: Colors.black,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' ')
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputStyles.getAuthInput(
                        hint: 'Phone'),
                    validator: viewModel.phoneValidator,
                    onSaved: (String? value) {
                      viewModel.inputPhone(value);
                    },
                    // initialValue: viewModel.username,
                    controller: TextEditingController(text: viewModel.phone),
                    style: const TextStyle(color: Colors.black),

                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    cursorColor: Colors.black,
                    obscureText: !viewModel.passwordVisible,
                    decoration: InputStyles.getAuthInput(
                      hint: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(viewModel.passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off, color: Colors.grey,),
                        onPressed: viewModel.togglePassword,
                      ),
                    ),
                    validator: viewModel.passwordValidator,
                    onSaved: viewModel.inputPassword,
                    style: const TextStyle(color: Colors.black),

                  ),

                  const SizedBox(height: 20,),

                  SizedBox(
                    width: double.infinity,
                    height: 45.0,
                    child: RaisedGradientButton(
                      gradient: const LinearGradient(
                        colors: <Color>[cButtonColor, cGradientColor2],
                      ),
                      onPressed: (){
                        viewModel.onSignupButtonClick(context);
                      },
                      isBusy: viewModel.isBusy,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  const Align(
                    alignment: Alignment.center,
                    child: Text('OR',
                    style: TextStyle(
                      color: cBlack50,
                      fontSize: 14
                    ),),
                  ),

                  const SizedBox(height: 20,),

                  Visibility(
                      visible: Platform.isIOS,
                      child: SignInWithAppleButton(
                        onPressed: () async {
                          final credential = await SignInWithApple.getAppleIDCredential(
                            scopes: [
                              AppleIDAuthorizationScopes.email,
                              AppleIDAuthorizationScopes.fullName,
                            ],
                          );
                          Authentication.socialLogin(context, credential.givenName!,
                              credential.email!, null, credential.userIdentifier, null);                        },
                      )
                  ),

                  Visibility(
                      visible: Platform.isIOS,
                      child: const SizedBox(height: 10,)),

                  // Container(
                  //     width: double.infinity,
                  //     height: 45.0,
                  //     decoration: const BoxDecoration(
                  //         color: Color(0xFF3B589C),
                  //         borderRadius: BorderRadius.all(Radius.circular(30.0)
                  //         )),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 10.0),
                  //           child: Image.asset('assets/fb_logo.png',
                  //             height: 50,
                  //             width: 50,),
                  //         ),
                  //         const Text('with Facebook',
                  //           style: TextStyle(
                  //               color: Colors.white
                  //           ),),
                  //         const Padding(
                  //           padding: EdgeInsets.only(right: 15.0),
                  //           child: Icon(Icons.arrow_forward_ios,
                  //           color: Colors.white,
                  //           size: 15,),
                  //         )
                  //       ],
                  //     )
                  // ),

                  const SizedBox(height: 10,),

                  FutureBuilder(
                    future: Authentication.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error initializing Firebase');
                      } else if (snapshot.connectionState == ConnectionState.done) {
                        return InkWell(
                          onTap: (){
                            viewModel.onClickGoogleLogin(context);
                          },
                          child: Container(
                              width: double.infinity,
                              height: 45.0,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFEC4235),
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Image.asset('assets/google_logo.png',
                                      height: 50,
                                      width: 50,),
                                  ),
                                  const Text('with Google',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 15,),
                                  )
                                ],
                              )
                          ),
                        );
                      }
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.orange,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: (){
                        viewModel.onContinueAsGuestClick(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Continue as Guest',
                          style: TextStyle(
                            color: Color(0xFF0064FE),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  SignupViewModel viewModelBuilder(BuildContext context) {
    final vm = SignupViewModel();
    return vm;
  }
}
