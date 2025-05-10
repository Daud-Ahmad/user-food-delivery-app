import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/raised_gradient_button.dart';
import '../../../../styles.dart';
import 'change_password_vm.dart';

class ChangePasswordScreen extends ViewModelBuilderWidget<ChangePasswordViewModel> {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ChangePasswordViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: viewModel.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                color: cButtonColor,
                padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20, right: 20),
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    InkWell(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,
                        color: Colors.white,),
                    ),

                    const Text('Change Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    Container(),
                  ],
                ),
              ),

              const SizedBox(height: 50,),

              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text('Old Password'),
              ),

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  obscureText: !viewModel.oldPasswordVisible,
                  decoration: InputStyles.getAuthInput(
                    hint: '',
                    suffixIcon: IconButton(
                      icon: Icon(viewModel.oldPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off, color: Colors.grey,),
                      onPressed: viewModel.toggleOldPassword,
                    ),
                  ),
                  validator: viewModel.oldPasswordValidator,
                  onSaved: viewModel.inputOldPassword,
                  style: const TextStyle(color: Colors.black),

                ),
              ),

              const SizedBox(height: 20.0),

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

              const SizedBox(height: 40.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: RaisedGradientButton(
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    gradient: const LinearGradient(
                      colors: <Color>[cButtonColor, cGradientColor2],
                    ),
                    onPressed: (){
                      viewModel.onSaveButtonClick(context);
                    },
                    isBusy: viewModel.isBusy,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar:  Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/home_screen',(r) => false, arguments: 0);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: viewModel.pageIndex == 0 ? cSelectedTabColor : cUnselectedTabColor,
                    size: 30,
                  ),
                  Text('Home',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: viewModel.pageIndex == 0 ? cSelectedTabColor : cUnselectedTabColor
                    ),)
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/home_screen',(r) => false, arguments: 1);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: viewModel.pageIndex == 1 ? cSelectedTabColor : cUnselectedTabColor,
                    size: 30,
                  ),
                  Text('Favourites',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: viewModel.pageIndex == 1 ? cSelectedTabColor : cUnselectedTabColor
                    ),)
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/home_screen',(r) => false, arguments: 2);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(
                  CupertinoIcons.bookmark,
                  color: viewModel.pageIndex == 2 ? cSelectedTabColor : cUnselectedTabColor,
                  size: 30,
                ),
                  Text('Orders',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: viewModel.pageIndex == 2 ? cSelectedTabColor : cUnselectedTabColor
                    ),)
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/home_screen',(r) => false, arguments: 3);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    color: viewModel.pageIndex == 3 ? cSelectedTabColor : cUnselectedTabColor,
                    size: 30,
                  ),
                  Text('Cart',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: viewModel.pageIndex == 3 ? cSelectedTabColor : cUnselectedTabColor
                    ),)
                ],
              ),
            ),
            InkWell(
              onTap: (){
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(
                  Icons.person,
                  color: viewModel.pageIndex == 4 ? cSelectedTabColor : cUnselectedTabColor,
                  size: 30,
                ),
                  Text('Profile',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: viewModel.pageIndex == 4 ? cSelectedTabColor : cUnselectedTabColor
                    ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ChangePasswordViewModel viewModelBuilder(BuildContext context) {
    final vm = ChangePasswordViewModel();
    return vm;
  }
}
