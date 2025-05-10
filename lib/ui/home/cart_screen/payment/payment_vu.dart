import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mura_user_app/config.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/loading_pages.dart';
import '../../../../components/raised_gradient_button.dart';
import '../../../../models/menu_response.dart';
import '../../../../styles.dart';
import 'paymeny_vm.dart';

class PaymentScreen extends ViewModelBuilderWidget<PaymentViewModel> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, PaymentViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric( vertical: 5),
                  child: Icon(Icons.arrow_back,
                    color: Colors.black,),
                ),
              ),

              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Checkout',
                  style: TextStyle(
                      color: cMessageColor,
                      fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              viewModel.isBusy
                  ? const Expanded(child: GettingRecords()) :

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 180,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10,),
                                const Text('Order Summary',
                                  style: TextStyle(
                                    color: cMessageColor,
                                    fontSize: 20,
                                  ),
                                ),

                                const SizedBox(height: 15,),

                                Expanded(
                                    child: ListView.builder(
                                        itemCount: AppConfig.menuResponseList.length,
                                        itemBuilder: (con, index) => orderSummaryListItem(AppConfig.menuResponseList[index])
                                    )
                                ),

                                const Divider(),

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

                              ],
                            )
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Delivery Address',
                                      style: TextStyle(
                                        color: cMessageColor,
                                        fontSize: 20,
                                      ),
                                    ),

                                    IconButton(onPressed: (){
                                      viewModel.onClickEditDeliveryAddress(context);
                                    }, icon: const Icon(Icons.edit))
                                  ],
                                ),


                                Text(AppConfig.deliveryAddress,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: cMessageColor,
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 5,),

                                const Divider(),

                                const SizedBox(height: 10,),

                              ],
                            )
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 110,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10,),
                                const Text('Payment Method',
                                  style: TextStyle(
                                    color: cMessageColor,
                                    fontSize: 20,
                                  ),
                                ),

                                const SizedBox(height: 20,),

                                Visibility(
                                  visible: viewModel.cardListResponse == null,
                                  child: InkWell(
                                    onTap: (){
                                      viewModel.onClickAddPaymentMethod(context);
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.add),
                                        SizedBox(width: 10,),
                                        Text('Add payment method',
                                          style: TextStyle(
                                            color: cMessageColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Visibility(
                                  visible: viewModel.cardListResponse != null,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [

                                          Text(viewModel.cardListResponse == null ? ''
                                              :viewModel.cardListResponse!.cardNumber,
                                            style: const TextStyle(
                                                color: cTextColorBlack,
                                                fontSize: 12
                                            ),),

                                          IconButton(onPressed: (){
                                            viewModel.onClickAddPaymentMethod(context);
                                          }, icon:  const Icon(Icons.keyboard_arrow_down_sharp))

                                        ],
                                      ),
                                      Text('£ ${AppConfig.total}',
                                        style: const TextStyle(
                                            color: cTextColorBlack,
                                            fontSize: 12
                                        ),),
                                    ],
                                  ),
                                ),

                              ],
                            )
                        ),
                      ),

                      const SizedBox(height: 10,),

                      SizedBox(
                        width: double.infinity,
                        height: 45.0,
                        child: RaisedGradientButton(
                          gradient: const LinearGradient(
                            colors: <Color>[cButtonColor, cGradientColor2],
                          ),
                          onPressed: (){
                            viewModel.onClickPlaceOrder(context);
                          },
                          isBusy: viewModel.isBusy,
                          child: const Text(
                            'Place Order',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        )
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

  Widget orderSummaryListItem(MenuResponse item){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text('${item.totalItems}x ${item.title}',
              style: const TextStyle(
                  color: cTextColorBlack,
                  fontSize: 12
              ),),

            Text('£ ${item.getTotalPrice()}',
              style: const TextStyle(
                  color: cTextColorBlack,
                  fontSize: 12
              ),),

          ],
        ),

        const SizedBox(height: 5,),
      ],
    );
  }

  @override
  PaymentViewModel viewModelBuilder(BuildContext context) {
    final vm = PaymentViewModel();
    vm.getCardListResponse(context);
    return vm;
  }
}
