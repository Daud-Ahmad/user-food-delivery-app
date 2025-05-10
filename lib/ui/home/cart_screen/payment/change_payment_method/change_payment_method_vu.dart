import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/raised_gradient_button.dart';
import '../../../../../styles.dart';
import 'change_payment_method_vm.dart';

class ChangePaymentMethodScreen extends ViewModelBuilderWidget<ChangePaymentMethodViewModel> {
  const ChangePaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ChangePaymentMethodViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              color: cButtonColor,
              padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20, right: 20),
              child:  InkWell(
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
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Text('Payment',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          const SizedBox(height: 15,),

          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text('Name of card',
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
                child: Row(
                  children: [
                    Image.asset('assets/master_card.png'),
                   const SizedBox(width: 10,),
                    Container(width: 2,
                    color: const Color(0xFF6C6C6C),
                    height: 30,),

                    const SizedBox(width: 15,),

                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Jon Doe Khan',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
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

                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child:     Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '1234-5678-9102-1234',
                      ),
                    ),
                  )
                ),
              )
          ),

          const SizedBox(height: 40,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RaisedGradientButton(
              child: const Text(
                'Change',
                style: TextStyle(color: Colors.white),
              ),
              gradient: const LinearGradient(
                colors: <Color>[cButtonColor, cGradientColor2],
              ),
              onPressed: (){
              },
              isBusy: viewModel.isBusy,
            ),
          ),

          const SizedBox(height: 15,),

          const Align(
            alignment: Alignment.center,
            child: Text('Remove Payment Method',
              style: TextStyle(
                fontSize: 12,
                  color: Color(0xFFFF0000,
              )),
            ),
          ),

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
  ChangePaymentMethodViewModel viewModelBuilder(BuildContext context) {
    final vm = ChangePaymentMethodViewModel();
    return vm;
  }
}
