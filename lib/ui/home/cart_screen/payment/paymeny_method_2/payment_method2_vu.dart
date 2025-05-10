import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/raised_gradient_button.dart';
import '../../../../../styles.dart';
import 'payment_method2_vm.dart';

class PaymentMethod2Screen extends ViewModelBuilderWidget<PaymentMethod2ViewModel> {
  const PaymentMethod2Screen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, PaymentMethod2ViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              color: cButtonColor,
              padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20, right: 20),
              child:   InkWell(
                onTap:(){
                  Navigator.pop(context);
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.arrow_back,
                    color: Colors.white,),
                ),
              ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text('Payment',
              style: TextStyle(
                color: cMessageColor,
                fontSize: 22,
              ),
            ),
          ),

          const Divider(
            color: cMessageColor,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child:   Row(
              children: [
                Radio(value: viewModel.applePay, groupValue: viewModel.applePay, onChanged: (change) => {}),
                const SizedBox(width: 5,),
                const Text('Apple Pay',
                  style: TextStyle(
                    color: cMessageColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            color: cMessageColor,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child:   Row(
              children: [
                Radio(value: false, groupValue: viewModel.applePay, onChanged: (change) => {}),
                const SizedBox(width: 5,),
                const Text('Credit/Debit Card',
                  style: TextStyle(
                    color: cMessageColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            color: cMessageColor,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child:   Row(
              children: [
                Radio(value: false, groupValue: viewModel.applePay, onChanged: (change) => {}),
                const SizedBox(width: 5,),
                const Text('PayPal',
                  style: TextStyle(
                    color: cMessageColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            color: cMessageColor,
          ),

          Expanded(child: Container()),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RaisedGradientButton(
              child: const Text(
                'Apply',
                style: TextStyle(color: Colors.white),
              ),
              gradient: const LinearGradient(
                colors: <Color>[cButtonColor, cGradientColor2],
              ),
              onPressed: (){
                viewModel.onClickApply(context);
              },
              isBusy: viewModel.isBusy,
            ),
          ),

          const SizedBox(height: 10,),

        ],
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
  PaymentMethod2ViewModel viewModelBuilder(BuildContext context) {
    final vm = PaymentMethod2ViewModel();
    return vm;
  }
}
