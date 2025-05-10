import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/raised_gradient_button.dart';
import '../../../../../styles.dart';
import 'credit_card_info_vm.dart';

class CreditCardInfoScreen extends ViewModelBuilderWidget<CreditCardInfoViewModel> {
  const CreditCardInfoScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, CreditCardInfoViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: viewModel.formKey,
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  ],
                )
            ),

            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(viewModel.cardListResponse == null ? 'Add payment method' : 'Edit payment method',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            const SizedBox(height: 15,),

            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text('Card Number',
                style: TextStyle(color: Colors.black),),
            ),

            const SizedBox(height: 5,),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                    child:     Expanded(
                      child: TextFormField(
                        onSaved: (String? value) {
                          viewModel.inputCardNumber(value);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                        controller: TextEditingController(text: viewModel.cardNumber),
                      ),
                    )
                  ),
                )
            ),

            const SizedBox(height: 15,),

            Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text('CVC',
                        style: TextStyle(color: Colors.black),),
                    ),

                    const SizedBox(height: 5,),

                    Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                              child:     Expanded(
                                child: TextFormField(
                                  maxLength: 3,
                                  onSaved: (String? value) {
                                    viewModel.inputCvc(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '',
                                    counterText: ''
                                  ),
                                  controller: TextEditingController(text: viewModel.cvc),
                                ),
                              )
                          ),
                        )
                    ),

                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text('Expiry',
                        style: TextStyle(color: Colors.black),),
                    ),

                    const SizedBox(height: 5,),

                    Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child:     Expanded(
                                child: TextFormField(
                                  onSaved: (String? value) {
                                    viewModel.inputExpiry(value);
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'mm/yyyy',
                                  ),
                                  controller: TextEditingController(text: viewModel.expiry),
                                ),
                              )
                          ),
                        )
                    ),

                  ],
                ),
              ),
            ],),

            const SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RaisedGradientButton(
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                gradient: const LinearGradient(
                  colors: <Color>[cButtonColor, cGradientColor2],
                ),
                onPressed: (){
                  viewModel.onClickSave(context);
                },
                isBusy: viewModel.isBusy,
              ),
            ),

          ],
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
                Navigator.pushNamedAndRemoveUntil(context, '/home_screen',(r) => false, arguments: 4);
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
  CreditCardInfoViewModel viewModelBuilder(BuildContext context) {
    final vm = CreditCardInfoViewModel();
    vm.getCartInfo(context);
    return vm;
  }
}
