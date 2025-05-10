import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../config.dart';
import '../../styles.dart';
import 'order_place_successfully_vm.dart';

class OrderPlaceSuccessfullyScreen extends ViewModelBuilderWidget<OrderPlaceSuccessfullyViewModel> {
  const OrderPlaceSuccessfullyScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, OrderPlaceSuccessfullyViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/home_screen',(r) => false, arguments: 0);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric( vertical: 5),
                  child: Icon(Icons.arrow_back,
                    color: Colors.black,),
                ),
              ),
            ),

            Expanded(child: Container()),
            Center(child: Image.asset('assets/circle_tick.png')),

            const SizedBox(height: 20,),

            const Center(
              child: Text('Order Successfully Placed',
              style: TextStyle(
                color: cMessageColor,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),),
            ),

            const SizedBox(height: 10,),

            Center(
              child: Text('You’ll receive your food on ${AppConfig.pickupDeliveryDate} ${viewModel.time}\nThank you for using our service, Enjoy your steaming hot food',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF6C6C6C),
                  fontSize: 14,
                ),),
            ),

            const SizedBox(height: 30,),

            // Center(
            //   child: SizedBox(
            //     width: 280,
            //     height: 45.0,
            //     child: RaisedGradientButton(
            //       gradient: const LinearGradient(
            //         colors: <Color>[cButtonColor, cGradientColor2],
            //       ),
            //       onPressed: (){
            //         // viewModel.onClickTrackYourOrder(context);
            //       },
            //       isBusy: viewModel.isBusy,
            //       child: const Text(
            //         'Track your order',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 30,),

            Center(
              child: InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/home_screen',(r) => false, arguments: 2);
                },
                child: Container(
                  width: 200,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: const Color(0xFF8660D8))
                  ),
                  child: const Material(
                    color: Colors.transparent,
                    child: Center(
                      child:Text('See order Details',
                        style: TextStyle(color: cSelectedTabColor,
                            fontSize: 14),),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(child: Container()),
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
  OrderPlaceSuccessfullyViewModel viewModelBuilder(BuildContext context){
    OrderPlaceSuccessfullyViewModel vm = OrderPlaceSuccessfullyViewModel();
    vm.getData(context);
    return vm;
  }
}
