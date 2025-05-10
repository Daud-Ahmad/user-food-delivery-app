import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/raised_gradient_button.dart';
import '../../../../styles.dart';
import 'subscription_vm.dart';

class SubscriptionScreen extends ViewModelBuilderWidget<SubscriptionViewModel> {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, SubscriptionViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap:(){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.clear,
                color: Colors.black,),
              ),

              const SizedBox(height: 20,),

               const Align(
                 alignment: Alignment.center,
                 child: Text('Subscription Service',
                  style: TextStyle(
                      color: cMessageColor,
                      fontSize: 20
                  ),),
               ),

              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 20),
                child: Row(
                  children: [

                    Expanded(
                      child: InkWell(
                        onTap: (){
                          viewModel.onClickOrders(context);
                        },
                        child: Card(
                          color: const Color(0xFF8660D8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const SizedBox(
                            height: 140,
                            child: Center(
                              child: Text('Active Orders',
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                ),),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Card(
                        color: const Color(0xFF8660D8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const SizedBox(
                          height: 140,
                          child: Center(
                            child: Text('Cancel Orders',
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Card(
                        color: const Color(0xFF8660D8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const SizedBox(
                          height: 140,
                          child: Center(
                            child: Text('Again Orders',
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 40,),

              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Change Schedule',
                  style: TextStyle(
                      color: cMessageColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
              ),

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: 200,
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20.0) //                 <--- border radius here
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: viewModel.selectedChangeSchedule,
                      hint: const Text(
                        'Select Screen here',
                        style: TextStyle(
                          color: cButtonColor,
                        ),
                      ),
                      items: viewModel.changeScheduleList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(fontSize: 12),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        viewModel.selectedChangeSchedule = value!;
                        viewModel.notifyListeners();
                      },
                      onTap: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    const Text('Change Quantity',
                      style: TextStyle(
                          color: cMessageColor,
                          fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),),

                    const SizedBox(width: 10,),

                    Container(
                      width: 100,
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(20.0) //                 <--- border radius here
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: viewModel.selectedChangeQuantity,
                          hint: const Text(
                            'Select Screen here',
                            style: TextStyle(
                              color: cButtonColor,
                            ),
                          ),
                          items: viewModel.changeQuantityList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(fontSize: 12),),
                            );
                          }).toList(),
                          onChanged: (value) {
                            viewModel.selectedChangeQuantity = value!;
                            viewModel.notifyListeners();
                          },
                          onTap: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30,),

              InkWell(
                onTap: (){
                  viewModel.onClickSwitchProduct(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text('Switch Product',
                    style: TextStyle(
                        color: cMessageColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                ),
              ),

              const SizedBox(height: 40,),

              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Cancel',
                  style: TextStyle(
                      color: Color(0xFFFF0000),
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
              ),

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: RaisedGradientButton(
                    child: const Text(
                      'Done',
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
              ),

              const SizedBox(height: 20,),

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
  SubscriptionViewModel viewModelBuilder(BuildContext context) {
    final vm = SubscriptionViewModel();
    return vm;
  }
}
