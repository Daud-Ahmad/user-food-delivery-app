import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/raised_gradient_button.dart';
import '../../../../../styles.dart';
import 'contact_us_vm.dart';

class ContactUsScreen extends ViewModelBuilderWidget<ContactUsViewModel> {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ContactUsViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const SizedBox(height: 60,),

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: InkWell(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.clear,
                    color: Colors.black,),
                ),
              ),

              const SizedBox(height: 10,),

              const Align(
                alignment: Alignment.center,
                child: Text('Contact Us',
                  style: TextStyle(
                      color: cMessageColor,
                      fontSize: 20
                  ),),
              ),

              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20.0) //                 <--- border radius here
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      maxLines: 5,
                      validator: viewModel.problemDescValidator,
                      onSaved: (String? value) {
                        viewModel.inputProblemDesc(value);
                      },
                      controller: TextEditingController(text: viewModel.problemDesc),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Problem Description',
                        labelStyle: TextStyle(color: cBlack50),
                      ),
                    ),
                  ),
                )
              ),

              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: viewModel.screenShortPath != null
                            ? SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: Image.file(
                            File(viewModel.screenShortPath!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                            : Container(
                          height: 300,
                          width: double.infinity,
                          color: const Color(0xFF393346),
                          child: Center(
                            child: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/no_image.png',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.contain,
                                  ),
                                  const Text('Add Screen Short (optional)', style: TextStyle(
                                      color: Colors.white
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: (){
                              viewModel.onClickScreenShortImage(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 5, top: 5, bottom: 5),
                              child: Image.asset('assets/icon_edit_image.png'),
                            ),
                          )),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: RaisedGradientButton(
                    gradient: const LinearGradient(
                      colors: <Color>[cButtonColor, cGradientColor2],
                    ),
                    onPressed: (){
                      viewModel.onClickSubmit(context);
                    },
                    isBusy: viewModel.isBusy,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

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
  ContactUsViewModel viewModelBuilder(BuildContext context) {
    final vm = ContactUsViewModel();
    return vm;
  }
}
