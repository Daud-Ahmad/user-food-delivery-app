import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../components/raised_gradient_button.dart';
import '../../../styles.dart';
import 'reset_vm.dart';

class ResetPasswordScreen extends ViewModelBuilderWidget<ResetPasswordViewModel> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ResetPasswordViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: viewModel.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                color: cButtonColor,
                padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20, right: 20),
                child: InkWell(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back,
                    color: Colors.white,),
                ),
              ),

              const SizedBox(height: 20.0),

              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text('Reset Password',
                style: TextStyle(fontSize: 20,),
                ),
              ),

              const SizedBox(height: 20,),

              Visibility(
               visible: viewModel.isShowEmailView,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text('Email'),
                    ),

                    const SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
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
                    ),

                  ],
                ),
              ),

              Visibility(
                visible: viewModel.isShowOtpView,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text('Enter Otp we send you through email'),
                    ),

                    const SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(' ')
                        ],
                        decoration: InputStyles.getAuthInput(
                            hint: 'OTP'),
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        validator: viewModel.otpValidator,
                        onSaved: (String? value) {
                          viewModel.inputOtp(value);
                        },
                        // initialValue: viewModel.username,
                        controller: TextEditingController(text: viewModel.otpFromUser),
                        style: const TextStyle(color: Colors.black),

                      ),
                    ),

                  ],
                ),
              ),

              Visibility(
                visible: viewModel.isShowForgetPasswordView,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text('New Password'),
                    ),

                    const SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        obscureText: !viewModel.newPasswordVisible,
                        decoration: InputStyles.getAuthInput(
                          hint: '',
                          suffixIcon: IconButton(
                            icon: Icon(viewModel.newPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off, color: Colors.grey,),
                            onPressed: viewModel.toggleNewPassword,
                          ),
                        ),
                        validator: viewModel.newPasswordValidator,
                        onSaved: viewModel.inputNewPassword,
                        style: const TextStyle(color: Colors.black),

                      ),
                    ),

                    const SizedBox(height: 20.0),

                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text('Confirm Password'),
                    ),

                    const SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        obscureText: !viewModel.confirmPasswordVisible,
                        decoration: InputStyles.getAuthInput(
                          hint: '',
                          suffixIcon: IconButton(
                            icon: Icon(viewModel.confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off, color: Colors.grey,),
                            onPressed: viewModel.toggleConfirmPassword,
                          ),
                        ),
                        validator: viewModel.confirmPasswordValidator,
                        onSaved: viewModel.inputConfirmPassword,
                        style: const TextStyle(color: Colors.black),

                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: RaisedGradientButton(
                    gradient: const LinearGradient(
                      colors: <Color>[cButtonColor, cGradientColor2],
                    ),
                    onPressed: (){
                      viewModel.isShowEmailView ?
                      viewModel.onResetButtonClick(context) :
                      viewModel.isShowOtpView ?
                      viewModel.verifyOtp(context) : viewModel.onSetPassword(context);
                    },
                    isBusy: viewModel.isBusy,
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  ResetPasswordViewModel viewModelBuilder(BuildContext context) {
    final vm = ResetPasswordViewModel();
    return vm;
  }
}
