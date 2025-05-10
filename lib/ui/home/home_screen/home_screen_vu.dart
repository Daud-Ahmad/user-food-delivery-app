import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../components/images.dart';
import '../../../components/loading_pages.dart';
import '../../../config.dart';
import '../../../models/menu_type.dart';
import '../../../styles.dart';
import 'home_screen_vm.dart';

class TabHomeScreen extends ViewModelBuilderWidget<TabHomeScreenViewModel> {
  const TabHomeScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TabHomeScreenViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: cButtonColor,
            padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      viewModel.onClickCurrentLocation();
                    },
                    child: Row(
                      children: [
                        const Text('Deliver to: ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Expanded(
                          child: Text(AppConfig.deliveryAddress.isEmpty ? 'Current Location' :
                          AppConfig.deliveryAddress,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal
                            ),),
                        )
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: viewModel.isShowAddAddressView,
                  child: InkWell(
                    onTap: (){
                      viewModel.onClickCancel();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10),
                      child: Icon(CupertinoIcons.clear,
                      size: 20,
                      color: Colors.white,),
                    ),
                  ),
                )

              ],
            ),
          ),

          Visibility(
            visible: viewModel.isShowAddAddressView,
              child: const SizedBox(height: 10,)),

          Visibility(
            visible: viewModel.isShowAddAddressView,
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    viewModel.determinePosition(context, false);
                    },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
                    child: Row(
                      children: const [
                        Icon(Icons.my_location_outlined,
                        size: 18,
                        color: Color(0xFF6660D8),),
                        SizedBox(width: 20,),
                        Text('Current Location',
                          style: TextStyle(
                              color: cTitleColor,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFD8D8D8),
                ),

                InkWell(
                  onTap: (){
                    viewModel.onClickAddNewAddress(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
                    child: Row(
                      children: const [
                        Icon(Icons.add,
                          size: 18,
                          color: Color(0xFF6660D8),),
                        SizedBox(width: 20,),
                        Text('Add a new Address',
                          style: TextStyle(
                              color: cTitleColor,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFD8D8D8),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(viewModel.greetingText,
              style: const TextStyle(
                  color: cTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),

          const SizedBox(height: 5,),

          const Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Text('Never miss a meal again!!!',
              style: TextStyle(
                  color: cMessageColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),

          const SizedBox(height: 10,),

          viewModel.isBusy
              ? const Expanded(child: GettingRecords())
              : viewModel.menuTypeList.isEmpty
              ? const Expanded(child: NoRecord('No Menu Record',)) :
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                  itemCount: viewModel.menuTypeList.length,
                  itemBuilder: (con, index) => menuTypeListItem(context,
                      viewModel.menuTypeList[index], viewModel, index)
              )
          )

        ],
      )

    );
  }

  Widget menuTypeListItem(BuildContext context, MenuType item, TabHomeScreenViewModel viewModel, int index){
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
      child: InkWell(
        onTap: (){
          viewModel.onClickOrderNow(context, index);
        },
        child: Card(
          color: const Color(0xFF865FD7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            height: 170,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const Text('Single containers, palettes and food options',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                        Container(
                            width: 100,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.white,),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Order Now',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
                CHINetworkImage(
                  item.image == null ? '' :
                  AppConfig.imageBaseUrl+item.image,
                  width: 130,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  @override
  TabHomeScreenViewModel viewModelBuilder(BuildContext context)
  {
    TabHomeScreenViewModel vm = TabHomeScreenViewModel();
    vm.startScreenGettingData(context);
    return vm;
  }
}
