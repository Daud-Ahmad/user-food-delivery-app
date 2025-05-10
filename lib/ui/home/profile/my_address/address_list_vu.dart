import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../components/loading_pages.dart';
import '../../../../../components/raised_gradient_button.dart';
import '../../../../../styles.dart';
import '../../../../config.dart';
import '../../../../models/address_list_response.dart';
import 'address_list_vm.dart';

class AddressListScreen extends ViewModelBuilderWidget<AddressListViewModel> {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, AddressListViewModel viewModel, Widget? child) {
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

                  const Text('Address',
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
              viewModel.onClickAddNewAddress(context);
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.add),
                  SizedBox(width: 10,),
                  Text('Add New Address',
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
              AppConfig.addressList.isEmpty ?
                      const NoRecord('Please Add Address') :
                  ListView.builder(
                    padding: EdgeInsets.zero,
                  itemCount: AppConfig.addressList.length,
                  itemBuilder: (con, index) => cardListItem(AppConfig.addressList[index],
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

  Widget cardListItem(AddressListResponse item,
      AddressListViewModel viewModel, int index, BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),

          Text(item.title,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: cTextColorBlack,
                fontSize: 15,
              fontWeight: FontWeight.bold
            ),),

          const SizedBox(height: 10,),

          Visibility(
            visible: viewModel.screenName != null,
            child: SizedBox(
              height: 40.0,
              child: RaisedGradientButton(
                gradient: const LinearGradient(
                  colors: <Color>[cButtonColor, cGradientColor2],
                ),
                onPressed: (){
                  viewModel.onClickSelect(context, index);
                },
                isBusy: viewModel.isBusy,
                child: const Text(
                  'Select',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          const Divider()
        ],
      ),
    );
  }

  @override
  AddressListViewModel viewModelBuilder(BuildContext context) {
    final vm = AddressListViewModel();
    vm.getScreenName(context);
    vm.getAddressList(context);
    return vm;
  }
}
