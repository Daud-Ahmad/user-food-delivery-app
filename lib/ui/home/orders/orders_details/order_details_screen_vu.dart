import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mura_user_app/config.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/loading_pages.dart';
import '../../../../models/orders_detail_resp.dart';
import '../../../../styles.dart';
import 'order_details_vm.dart';

class OrderDetailScreen extends ViewModelBuilderWidget<OrderDetailsViewModel> {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, OrderDetailsViewModel viewModel, Widget? child) {
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

                const Text('Order Details',
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

          viewModel.isBusy
              ? const Expanded(child: GettingRecords())
              : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Order',
                            style:  TextStyle(
                                color: cMessageColor,
                                fontSize: 16
                            ),),
                          const SizedBox(width: 5,),
                          Text('#${viewModel.orderDetailResp == null ? '...' : viewModel.orderDetailResp!.id}',
                            style:  const TextStyle(
                                color: cSelectedTabColor,
                                fontSize: 16
                            ),),

                        ],
                      ),

                      const SizedBox(height: 5,),

                      Text(viewModel.orderDetailResp!.userDetail!.address!.title,
                        style:  const TextStyle(
                            color: Color(0xFF6D6D6D),
                            fontSize: 12
                        ),),

                      const SizedBox(height: 15,),

                      Text(viewModel.orderDetailResp == null ? '....' :
                      '${viewModel.orderDetailResp!.pickupDeliveryDate} from ${viewModel.orderDetailResp!.startTime}  '
                          'To ${viewModel.orderDetailResp!.endTime}',
                        style:  const TextStyle(
                            color: cSelectedTabColor,
                            fontSize: 16
                        ),),

                      const SizedBox(height: 10,),

                    ],
                  ),
                ),

                Container(
                  height: 20,
                  color: const Color(0xFFf1f1f1),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),

                        Expanded(child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: viewModel.orderDetailResp == null ? 0 :
                          viewModel.orderDetailResp!.itemDetailsList!.length,
                            itemBuilder: (con, index) => menuListItem(viewModel.orderDetailResp == null ? null :
                            viewModel.orderDetailResp!.itemDetailsList![index])
                        )),

                        const SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal',
                              style: TextStyle(
                                  color: cTextColorBlack,
                                  fontSize: 12
                              ),),
                            Text('£ ${viewModel.getSubTotalAmount()}',
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
                            Text('£ ${viewModel.orderDetailResp!.deliveryCharge}',
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
                            Text('£ ${viewModel.orderDetailResp!.tax}',
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
                            Text('£ ${viewModel.orderDetailResp == null ? '...' : viewModel.getTotalAmount()}',
                              style: const TextStyle(
                                  color: cTextColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 30,)

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

  Widget menuListItem(OrdersItems? item){
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
                          child: Text(item == null ? '...' : item.qty.toString(),
                            style: const TextStyle(color: cTextColorBlack),))
                  ),

                  const SizedBox(width: 10,),

                   Text(item == null ? '...' : item.itemDetailsList![0].title,
                    style: const TextStyle(
                        color: cTextColorBlack,
                        fontSize: 14
                    ),),

                ],
              ),
               Text('£ ${item == null ? '...' : item.itemDetailsList![0].price}',
                style: const TextStyle(
                    color: cTextColorBlack,
                    fontSize: 12
                ),),
            ],
          ),
        ),

        const Divider(),
      ],
    );
  }

  @override
  OrderDetailsViewModel viewModelBuilder(BuildContext context)
  {
    OrderDetailsViewModel vm = OrderDetailsViewModel();
    vm.getOrdersId(context);
    return vm;
  }
}
