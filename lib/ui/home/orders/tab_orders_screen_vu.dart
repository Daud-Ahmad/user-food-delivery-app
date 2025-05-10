import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../components/loading_pages.dart';
import '../../../models/orders_list_resp.dart';
import '../../../styles.dart';
import 'tab_orders_vm.dart';

class TabOrdersScreen extends ViewModelBuilderWidget<TabOrdersViewModel> {
  const TabOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TabOrdersViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: cButtonColor,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20, right: 20),
            child:   const Text('My orders',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                border: Border.all(color: const Color(0xFFF1F1F1),),
                borderRadius: const BorderRadius.all(
                    Radius.circular(8.0) //                 <--- border radius here
                ),
              ),
              child: Row(
                children: [

                  Expanded(
                    child: InkWell(
                      onTap : (){
                        viewModel.onPendingOrdersClick(context);
                      },
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: !viewModel.pendingOrders ? const Color(0xFFF1F1F1) : const Color(0xFF8660D8),
                            border: Border.all(color: !viewModel.pendingOrders ? const Color(0xFFF1F1F1) : const Color(0xFF8660D8),),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(8.0) //                 <--- border radius here
                            ),
                          ),
                          child: Center(
                            child: Text('Pending Orders',
                              style: TextStyle(
                                  color: !viewModel.pendingOrders ? const Color(0xFF8660D8) : Colors.white,
                                  fontSize: 10
                              ),),
                          )
                      ),
                    ),
                  ),

                  const VerticalDivider(),

                  Expanded(
                    child: InkWell(
                      onTap : (){
                        viewModel.onActiveOrdersClick(context);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: !viewModel.activeOrders ? const Color(0xFFF1F1F1) : const Color(0xFF8660D8),
                          border: Border.all(color: !viewModel.activeOrders ? const Color(0xFFF1F1F1) : const Color(0xFF8660D8),),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8.0) //                 <--- border radius here
                          ),
                        ),
                        child: Center(
                          child: Text('Active Orders',
                          style: TextStyle(
                            color: !viewModel.activeOrders ? const Color(0xFF8660D8) : Colors.white,
                            fontSize: 10
                          ),),
                        )
                      ),
                    ),
                  ),

                  const VerticalDivider(),

                  Expanded(
                    child: InkWell(
                      onTap : (){
                        viewModel.onCompletedOrdersClick(context);
                      },
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: !viewModel.completedOrders ? const Color(0xFFF1F1F1) : const Color(0xFF8660D8),
                            border: Border.all(color: !viewModel.completedOrders ? const Color(0xFFF1F1F1) : const Color(0xFF8660D8),),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(8.0) //                 <--- border radius here
                            ),
                          ),
                          child: Center(
                            child: Text('Completed Orders',
                              style: TextStyle(
                                  color: !viewModel.completedOrders ? const Color(0xFF8660D8) : Colors.white,
                                  fontSize: 10
                              ),),
                          )
                      ),
                    ),
                  ),

                  const VerticalDivider(),

                  Expanded(
                    child: InkWell(
                      onTap : (){
                        viewModel.onCancelsOrdersClick(context);
                      },
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: !viewModel.cancelsOrders ? const Color(0xFFF1F1F1) : const Color(0xFF8660D8),
                            border: Border.all(color: !viewModel.cancelsOrders ? const Color(0xFFF1F1F1) : const Color(0xFF8660D8),),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(8.0) //                 <--- border radius here
                            ),
                          ),
                          child: Center(
                            child: Text('Canceled Orders',
                              style: TextStyle(
                                  color: !viewModel.cancelsOrders ? const Color(0xFF8660D8) : Colors.white,
                                  fontSize: 10
                              ),),
                          )
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          viewModel.isBusy
              ? const Expanded(child: GettingRecords())
              : viewModel.ordersList.isEmpty
              ? const Expanded(child: NoRecord('No Record',)) :
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: viewModel.ordersList.length,
                  itemBuilder:(con, index) => ordersListItem(viewModel, context,
                  viewModel.ordersList[index], index)
              ),
            ),
          )

        ],
      )

    );
  }

  Widget ordersListItem(TabOrdersViewModel viewModel,
      BuildContext context, OrdersListResp item, int index){
    return InkWell(
      onTap: (){
        viewModel.onClickOrderDetail(context, index);
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            padding: const EdgeInsets.only(left: 20),
            height: 170,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const SizedBox(height: 5,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Order',
                        style:  TextStyle(
                            color: cMessageColor,
                            fontSize: 12
                        ),),
                      const SizedBox(width: 5,),
                      Text('#${item.id.toString()}',
                        style:  const TextStyle(
                            color: cMessageColor,
                            fontSize: 12
                        ),),

                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(viewModel.deliveryText,
                        style:  const TextStyle(
                            color: cMessageColor,
                            fontSize: 12
                        ),),
                      const SizedBox(height: 5,),
                      Text('${item.pickupDeliveryDate} from ${item.startTime} to ${item.endTime}',
                        style:  const TextStyle(
                            color: cMessageColor,
                            fontSize: 12
                        ),),

                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Menu',
                        style:  TextStyle(
                            color: cMessageColor,
                            fontSize: 12
                        ),),
                      const SizedBox(height: 5,),
                      Text(viewModel.ordersMenu(index),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:  const TextStyle(
                            color: cMessageColor,
                            fontSize: 12
                        ),),

                    ],
                  ),

              Align(
                alignment: Alignment.topRight,
                child:  Container(
                  width: 100,
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF7D52DC)),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20.0) //                 <--- border radius here
                    ),
                  ),
                  child: const Center(
                    child: Text('Order Details',
                      style: TextStyle(
                          color: Color(0xFF7D52DC),
                          fontSize: 12
                      ),),
                  ),
                ),
              ),
                  const SizedBox(height: 5,),

                ],
              ),
            )
        ),
      ),
    );
  }

  @override
  TabOrdersViewModel viewModelBuilder(BuildContext context)
  {
    TabOrdersViewModel vm = TabOrdersViewModel();
    vm.gettingOrdersList(context);
    return vm;
  }
}
