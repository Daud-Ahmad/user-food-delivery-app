import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mura_user_app/config.dart';
import 'package:stacked/stacked.dart';

import '../../../components/raised_gradient_button.dart';
import '../../../models/menu_response.dart';
import '../../../preferences.dart';
import '../../../styles.dart';
import 'cart_vm.dart';

class CartScreen extends ViewModelBuilderWidget<CartViewModel> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, CartViewModel viewModel, Widget? child) {
    return PlatformScaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            AppConfig.menuResponseList.isEmpty ?
            Center(
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset('assets/empty_cart.png'),
                    const SizedBox(height: 20,),
                    const Text('Cart Empty',
                      style: TextStyle(
                        color: cButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Order some items from the menu',
                      style: TextStyle(
                        color: Color(0xFF6C6868),
                        fontSize: 15,
                      ),
                    ),

                  ],
                ),
              ),
            ) :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),

              InkWell(
                onTap: (){
                  showChangeAddressBottomSheet(context, viewModel.getRecentDateFromDay(), viewModel);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 120,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(viewModel.isDelivery ? 'Delivery Time' : 'Pick-Up Time',
                                      style: const TextStyle(
                                          color: Color(0xFF3C3C3C),
                                          fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text('${viewModel.getRecentDateFromDay()}'
                                        '\nfrom ${AppConfig.menuResponseList[0].resTiming!.startTime} to '
                                        '${AppConfig.menuResponseList[0].resTiming!.endTime}',
                                      style: const TextStyle(
                                          color: Color(0xFF282828),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal
                                      ),),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                                      child: Text('Change',
                                        style: TextStyle(
                                            color: cSelectedTabColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal
                                        ),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [

                            Image.asset('assets/img_deliver_bg.png',
                            ),

                            Image.asset('assets/img_delivery.png',
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              Text(AppConfig.menuResponseList[0].restaurantName,
                style: const TextStyle(
                  color: cMessageColor,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 10,),

              Expanded(child: ListView.builder(
                itemCount: AppConfig.menuResponseList.length,
                  itemBuilder: (con, index) => menuListItem(index,  AppConfig.menuResponseList[index], viewModel)
              )
              ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sub Total',
                    style: TextStyle(
                        color: cTextColorBlack,
                        fontSize: 12
                    ),),
                  Text('£ ${AppConfig.subTotal}',
                    style: const TextStyle(
                        color: cTextColorBlack,
                        fontSize: 12
                    ),),
                ],
              ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery Fee',
                    style: TextStyle(
                        color: cTextColorBlack,
                        fontSize: 12
                    ),),
                  Text('£ ${AppConfig.menuResponseList[0].deliveryFee}',
                    style: const TextStyle(
                        color: cTextColorBlack,
                        fontSize: 12
                    ),),
                ],
              ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sales Tax',
                    style: TextStyle(
                        color: cTextColorBlack,
                        fontSize: 12
                    ),),
                  Text('£ ${viewModel.getTaxAmount()}',
                    style: const TextStyle(
                        color: cTextColorBlack,
                        fontSize: 12
                    ),),
                ],
              ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total (Including GST)',
                    style: TextStyle(
                        color: cTextColorBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),),
                  Text('£ ${AppConfig.total}',
                    style: const TextStyle(
                        color: cTextColorBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),),
                ],
              ),

              const SizedBox(height: 30,),

              SizedBox(
                width: double.infinity,
                height: 45.0,
                child: RaisedGradientButton(
                  gradient: const LinearGradient(
                    colors: <Color>[cButtonColor, cGradientColor2],
                  ),
                  onPressed: () async{
                    final token = await Preferences.getKey(Preferences.kToken);
                    if(token == null || token.isEmpty){
                      showCLoginBottomSheet(context, viewModel);
                    }
                    else{
                      viewModel.onClickContinue(context);
                    }
                  },
                  isBusy: viewModel.isBusy,
                  child: const Text(
                    'Review Payment And Address',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }

  showChangeAddressBottomSheet(BuildContext context, String recentTime, CartViewModel vm){

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 300.0,
                color: const Color(0xFF737373),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40.0, horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    vm.onClickDelivery();
                                  });
                                },
                                child: Column(
                                  children: [
                                    const Text('Delivery',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF302F2F)
                                      ),),
                                    const SizedBox(height: 5,),
                                    Visibility(
                                      visible: vm.isDelivery,
                                      child: Container(
                                        color: cSelectedTabColor,
                                        height: 2,
                                        width: 60,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    vm.onClickPickup();
                                  });
                                },
                                child: Column(
                                  children: [
                                    const Text('Pick-Up',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF302F2F)
                                      ),),
                                    const SizedBox(height: 5,),
                                    Visibility(
                                      visible: !vm.isDelivery,
                                      child: Container(
                                        color: cSelectedTabColor,
                                        height: 2,
                                        width: 60,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(recentTime,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF302F2F)
                            ),),
                        ),

                        const Divider(),

                        const SizedBox(height: 50,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 45.0,
                            child: RaisedGradientButton(
                              child: const Text(
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                              gradient: const LinearGradient(
                                colors: <Color>[cButtonColor, cGradientColor2],
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              isBusy: false,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              );
            });
        });

  }

  showCLoginBottomSheet(BuildContext context, CartViewModel viewModel){
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 300.0,
            color: const Color(0xFF737373),
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'Sign In or Sign Up',
                        style: TextStyle(color: Color(0xFF302F2F),
                        fontSize: 20),
                      ),

                      const SizedBox(height: 20,),

                      Visibility(
                        visible: Platform.isIOS,
                        child: InkWell(
                          onTap: ()async{
                            viewModel.onClickLogin(context);
                            },
                          child: Container(
                              width: double.infinity,
                              height: 45.0,
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/apple_logo.png',
                                    height: 50,
                                    width: 50,),
                                  const Text('Sign in with Apple',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),)
                                ],
                              )
                          ),
                        ),
                      ),

                      Visibility(
                          visible: Platform.isIOS,
                          child: const SizedBox(height: 10,)),

                      InkWell(
                        onTap: (){
                          viewModel.onClickLogin(context);
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
                      ),

                      const SizedBox(height: 10,),

                      const Align(
                        alignment: Alignment.center,
                        child: Text('OR',
                          style: TextStyle(
                              color: cBlack50,
                              fontSize: 14
                          ),),
                      ),

                      const SizedBox(height: 10,),

                      SizedBox(
                        width: double.infinity,
                        height: 45.0,
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                            border: Border.all(color: const Color(0xFF8660D8))
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: (){
                                  viewModel.onClickLogin(context);
                                },
                                child: const Center(
                                  child:Text('Continue with email',
                                  style: TextStyle(color: cSelectedTabColor,
                                  fontSize: 14),),
                                )),
                          ),
                        )
                      ),
                    ],
                  ),
                )
            ),
          );
        });

  }

  Widget menuListItem(int index, MenuResponse item, CartViewModel viewModel){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width:20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius:  BorderRadius.circular(4),
                          border:  Border.all(color: const Color(0xFFBDBDBD))
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('${index + 1}',
                            style: const TextStyle(color: cTextColorBlack),))
                  ),

                  const SizedBox(width: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(item.title,
                        style: const TextStyle(
                            color: cTextColorBlack,
                            fontSize: 14
                        ),),

                      const SizedBox(height: 5,),

                      Text('£ ${item.price}',
                        style: const TextStyle(
                            color: cTextColorBlack,
                            fontSize: 14
                        ),),

                    ],
                  ),

                ],
              ),

              Row(
                children: [

                  IconButton(onPressed: (){
                    viewModel.minusOneItem(index);
                  },
                      icon:  const Icon(Icons.remove_circle,
                        color: Color(0xFFC2BEBE),
                        size: 25,)),

                  Text(item.totalItems.toString(),
                    style: const TextStyle(
                        color: cTextColorBlack,
                        fontSize: 14
                    ),),

                  IconButton(onPressed: (){
                    viewModel.addOneItem(index);
                  },
                      icon: const Icon(Icons.add_circle,
                        color: cSelectedTabColor,
                        size: 25,),),

                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  @override
  CartViewModel viewModelBuilder(BuildContext context) {
    final vm = CartViewModel();
    if(AppConfig.menuResponseList.isNotEmpty){
      vm.calculateSubTotal();
      vm.calculateTotal();
    }
    return vm;
  }
}
