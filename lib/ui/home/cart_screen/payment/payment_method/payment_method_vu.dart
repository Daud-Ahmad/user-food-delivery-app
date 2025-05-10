import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/loading_pages.dart';
import '../../../../../components/raised_gradient_button.dart';
import '../../../../../models/card_list_response.dart';
import '../../../../../styles.dart';
import 'payment_method_vm.dart';

class PaymentMethodScreen extends ViewModelBuilderWidget<PaymentMethodViewModel> {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, PaymentMethodViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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

                  const Text('Payment',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Container()
                ],
              )
          ),

          const SizedBox(
            height: 20,
          ),

          InkWell(
            onTap: (){
              // viewModel.onClickAddPaymentMethod(context);
              viewModel.onClickAddPaymentMethod(context);
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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


          Expanded(
              child:  viewModel.isBusy
                  ? const GettingRecords() :
                  viewModel.cardList.isEmpty ?
                      const NoRecord('Please Add Card for payment method') :
                  ListView.builder(
                    padding: EdgeInsets.zero,
                  itemCount: viewModel.cardList.length,
                  itemBuilder: (con, index) => cardListItem(viewModel.cardList[index],
                      viewModel, index, context)
              )
          )

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

  Widget cardListItem(CardListResponse item,
      PaymentMethodViewModel viewModel, int index, BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 120,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Row(
                  children: [

                    const Text('Card Number : ',
                      style: TextStyle(
                          color: cTextColorBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),),

                    Text(item.cardNumber,
                      style: const TextStyle(
                          color: cTextColorBlack,
                          fontSize: 15
                      ),),

                  ],
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [

                    const Text('CVC : ',
                      style: TextStyle(
                          color: cTextColorBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),),
                    Text(item.cvc,
                      style: const TextStyle(
                          color: cTextColorBlack,
                          fontSize: 15
                      ),),

                    const SizedBox(width: 20,),

                    const Text('Expiry : ',
                      style: TextStyle(
                          color: cTextColorBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),),

                    Text('${item.expMonth}/${item.expYear}',
                      style: const TextStyle(
                          color: cTextColorBlack,
                          fontSize: 15
                      ),),
                  ],
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [
                    Visibility(
                      visible: viewModel.screenName == null,
                      child: Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: RaisedGradientButton(
                            child: const Text(
                              'Delete card',
                              style: TextStyle(color: Colors.white),
                            ),
                            gradient: const LinearGradient(
                              colors: <Color>[cButtonColor, cGradientColor2],
                            ),
                            onPressed: (){
                              viewModel.deleteCard(context, index);
                            },
                            isBusy: viewModel.isBusy,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: SizedBox(
                        height: 40.0,
                        child: RaisedGradientButton(
                          child: Text(
                            viewModel.screenName == null ? 'Edit card' : 'Select card',
                            style: const TextStyle(color: Colors.white),
                          ),
                          gradient: const LinearGradient(
                            colors: <Color>[cButtonColor, cGradientColor2],
                          ),
                          onPressed: (){
                            viewModel.onClickCartItem(context, index);
                          },
                          isBusy: viewModel.isBusy,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            )
        ),
      ),
    );
  }

  void reviewCode(){
    // Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         children: [
    //           Image.asset('assets/paypal.png',),
    //           const SizedBox(width: 10,),
    //           const Text('Pay Pal',
    //             style: TextStyle(
    //               color: cMessageColor,
    //               fontSize: 12,
    //             ),
    //           ),
    //         ],
    //       ),
    //
    //       const Icon(Icons.arrow_forward_ios_sharp,
    //           color: Color(0xFF8B8B8B))
    //     ],
    //   ),
    // ),
    //
    // const Divider(
    //   color: cMessageColor,
    // ),
    //
    // Padding(
    //   padding: const EdgeInsets.only(top: 10.0,bottom: 10, left: 20, right: 15),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         children: [
    //           Image.asset('assets/visa.png',),
    //           const SizedBox(width: 10,),
    //           Image.asset('assets/dot.png'),
    //           Image.asset('assets/dot.png'),
    //           Image.asset('assets/dot.png'),
    //           Image.asset('assets/dot.png'),
    //           InkWell(
    //             onTap: (){
    //               viewModel.onClickFiveSixSeven(context);
    //             },
    //             child: const Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
    //               child: Text('1234',
    //                 style: TextStyle(
    //                   color: cMessageColor,
    //                   fontSize: 12,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //
    //       InkWell(
    //         onTap: (){
    //           viewModel.onClickAddPaymentMethod(context);
    //         },
    //         child: const Padding(
    //           padding: EdgeInsets.all(5.0),
    //           child: Icon(Icons.arrow_forward_ios_sharp,
    //               color: Color(0xFF8B8B8B)),
    //         ),
    //       )
    //     ],
    //   ),
    // ),
    //
    // const Divider(
    //   color: cMessageColor,
    // ),
    //
    // Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         children: [
    //           Image.asset('assets/master_card.png',),
    //           const SizedBox(width: 10,),
    //           Image.asset('assets/dot.png'),
    //           Image.asset('assets/dot.png'),
    //           Image.asset('assets/dot.png'),
    //           Image.asset('assets/dot.png'),
    //           InkWell(
    //             onTap: (){
    //               viewModel.onClickFiveSixSeven(context);
    //             },
    //             child: const Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
    //               child: Text('5678',
    //                 style: TextStyle(
    //                   color: cMessageColor,
    //                   fontSize: 12,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //
    //       const Icon(Icons.arrow_forward_ios_sharp,
    //           color: Color(0xFF8B8B8B))
    //     ],
    //   ),
    // ),
    //
    // const Divider(
    //   color: cMessageColor,
    // ),
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //   child: RaisedGradientButton(
    //     child: const Text(
    //       'Apply',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     gradient: const LinearGradient(
    //       colors: <Color>[cButtonColor, cGradientColor2],
    //     ),
    //     onPressed: (){
    //       viewModel.onClickApply(context);
    //     },
    //     isBusy: viewModel.isBusy,
    //   ),
    // ),
  }

  @override
  PaymentMethodViewModel viewModelBuilder(BuildContext context) {
    final vm = PaymentMethodViewModel();
    vm.getScreenName(context);
    vm.getCardList(context);
    return vm;
  }
}
