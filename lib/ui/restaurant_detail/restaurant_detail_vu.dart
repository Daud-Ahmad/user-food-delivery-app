import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../components/bottom_navigation_item_click.dart';
import '../../components/images.dart';
import '../../components/loading_pages.dart';
import '../../config.dart';
import '../../models/menu_response.dart';
import '../../styles.dart';
import 'restaurant_detail_vm.dart';

class RestaurantDetailScreen extends ViewModelBuilderWidget<RestaurantDetailViewModel> {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, RestaurantDetailViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CHINetworkImage(
                viewModel.restaurant == null ? '' : AppConfig.imageBaseUrl +  viewModel.restaurant!.profileImage,
                height: 250,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.black.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.only(top:50, left: 20, bottom: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                          child: Image.asset('assets/arrow_back.png')),
                      Align(
                        alignment: Alignment.center,
                        child: Text(viewModel.restaurant == null ? '' : viewModel.restaurant!.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFFAFAFA),),
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                          child: Row(
                            children: [
                              Text(viewModel.restaurant == null ? '0.0' :
                              viewModel.getRating(),
                              style: const TextStyle(color: cSelectedTabColor,
                              fontSize: 12)
                                ),
                              const Icon(Icons.star,
                                  color: cSelectedTabColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),),
                          InkWell(
                            onTap: (){
                              viewModel.onClickHeart(context);
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                              child: Center(child: Icon(
                                viewModel.restaurant!.liked == 1 ? CupertinoIcons.heart_fill : CupertinoIcons.heart, size: 20,
                                color: cSelectedTabColor,
                              )
                              ),
                            ),
                          ),

                      ],)
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFFF1F1F1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Row(
                children: [

                  Expanded(
                    flex: 3,
                    child: Visibility(
                      visible: viewModel.hideView,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFAFAFA),),
                          color: const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [

                                  Text('Pre-order by',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                  SizedBox(height: 15,),

                                  Text('Wednesday',
                                    style: TextStyle(
                                        color: Color(0xFF6A6A6A),
                                        fontSize: 12
                                    ),
                                  ),

                                  Text('27th 9pm',
                                    style: TextStyle(
                                        color: Color(0xFF6A6A6A),
                                        fontSize: 12
                                    ),
                                  ),

                                ],
                              ),

                              const SizedBox(width: 10,),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [

                                  Text('Delivery for',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                  SizedBox(height: 22,),

                                  Text('Friday 29th',
                                    style: TextStyle(
                                        color: Color(0xFF6A6A6A),
                                        fontSize: 12
                                    ),
                                  ),

                                ],
                              )

                            ],
                          ),
                        ),),
                    ),
                  ),

                  const SizedBox(width: 10,),

                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        viewModel.onClickCertificateAndReview(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFAFAFA),),
                          color: const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(
                                child: Text('Certification and reviews',
                                    style: TextStyle(color: Colors.black,
                                        fontSize: 12)
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_sharp,
                                color: cSelectedTabColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),),
                    ),
                  ),

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

                Text('Menu',
                  style: TextStyle(color: cMessageColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),),

              ],
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Expanded(
            child:
            viewModel.isBusy
                ? const GettingRecords() :
    viewModel.menuResponseList.isEmpty ? const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: NoRecord('Restaurant Have no menu.'
          ' please select another restaurant'),
    ) :
    ListView.builder(
                itemCount: viewModel.menuResponseList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (con, index) => menuListItem(viewModel, context, viewModel.menuResponseList[index])
            )
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
                onBottomNavigationBarItemClick(context, 1);
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
                onBottomNavigationBarItemClick(context, 2);
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
                onBottomNavigationBarItemClick(context, 3);
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
                onBottomNavigationBarItemClick(context, 4);
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

  Widget menuListItem(RestaurantDetailViewModel viewModel,
      BuildContext context, MenuResponse item){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          InkWell(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(item.title,
                        style: const TextStyle(color: cMessageColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),),

                      const SizedBox(height: 5,),

                      Text(item.description,
                        style: const TextStyle(color: cUnselectedTabColor,
                          fontSize: 12,),),

                      const SizedBox(height: 5,),

                      Text('£ ${item.price}',
                        style: const TextStyle(color: cMessageColor,
                            fontSize: 10,
                            fontWeight: FontWeight.normal),),

                    ],
                  ),
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CHINetworkImage(
                    item.image == null ? '' : AppConfig.imageBaseUrl +  item.image,
                    height: 64,
                    width: 84,
                    fit: BoxFit.fill,
                  ),

                )

              ],
            ),
            onTap: (){
              viewModel.onClickAddMenu(context, item);
            },
          ),

          const Divider(color: cMessageColor),

          const SizedBox(height: 15,),
        ],
      ),
    );
  }

  @override
  RestaurantDetailViewModel viewModelBuilder(BuildContext context) {
    RestaurantDetailViewModel vm = RestaurantDetailViewModel();
    vm.getRestaurant(context);
    return vm;
  }
}
