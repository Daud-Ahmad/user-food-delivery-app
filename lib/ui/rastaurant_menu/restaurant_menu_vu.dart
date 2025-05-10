import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../components/bottom_navigation_item_click.dart';
import '../../components/images.dart';
import '../../components/loading_pages.dart';
import '../../components/raised_gradient_button.dart';
import '../../config.dart';
import '../../styles.dart';
import 'restaurant_menu_vm.dart';

class RestaurantMenuScreen extends ViewModelBuilderWidget<RestaurantMenuViewModel> {
  const RestaurantMenuScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, RestaurantMenuViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CHINetworkImage(
                  viewModel.menuResponse == null ? '' :
                  viewModel.menuResponse!.image == null ? '' :
                  AppConfig.imageBaseUrl + viewModel.menuResponse!.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20, left: 20, bottom: 10, right: 20),
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/arrow_back.png')),
                ),

              ],
            ),
            Expanded(
              child:
              viewModel.isBusy
                  ? const GettingRecords() :
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(viewModel.menuResponse == null ? '' : viewModel.menuResponse!.title,
                            style: const TextStyle(color: cMessageColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),),

                          const SizedBox(height: 10,),

                          Text(viewModel.menuResponse == null ? '' : viewModel.menuResponse!.description,
                            style: const TextStyle(color: cTitleColor,
                                fontSize: 12),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Type',
                                  style: TextStyle(
                                      color: cMessageColor,
                                      fontSize: 12,
                                  ),),

                                Text(viewModel.menuDetailResponse == null ? '...' : viewModel.menuDetailResponse!.type.name,
                                  style: const TextStyle(
                                      color: Color(0xFFA8A8A8,),
                                      fontSize: 12,
                                  ),)

                              ],
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Dietary type',
                                  style: TextStyle(
                                    color: cMessageColor,
                                    fontSize: 12,
                                  ),),

                                Text(viewModel.menuDetailResponse == null ? '...' : viewModel.menuDetailResponse!.dietry.name,
                                  style: const TextStyle(
                                      color: Color(0xFFA8A8A8,),
                                      fontSize: 12,
                                  ),)

                              ],
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Cuisine',
                                  style: TextStyle(
                                    color: cMessageColor,
                                    fontSize: 12,
                                  ),),

                                Text(viewModel.menuDetailResponse == null ? '...' : viewModel.menuDetailResponse!.cuisine.name,
                                  style: const TextStyle(
                                      color: Color(0xFFA8A8A8,),
                                      fontSize: 12,
                                  ),)

                              ],
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Delivery Type',
                                  style: TextStyle(
                                    color: cMessageColor,
                                    fontSize: 12,
                                  ),),

                                Text(viewModel.menuDetailResponse == null ? '...' : viewModel.menuDetailResponse!.delivery.name,
                                  style: const TextStyle(
                                      color: Color(0xFFA8A8A8,),
                                      fontSize: 12,
                                  ),)

                              ],
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Pickup Time',
                                  style: TextStyle(
                                    color: cMessageColor,
                                    fontSize: 12,
                                  ),),

                                Text(viewModel.menuResponse == null ? '...' :
                                viewModel.menuResponse!.resTiming == null ? '...' :
                                '${viewModel.menuResponse!.resTiming!.startTime} - ${viewModel.menuResponse!.resTiming!.endTime}',
                                  style: const TextStyle(
                                      color: Color(0xFFA8A8A8,),
                                      fontSize: 12,
                                  ),)

                              ],
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('Instructions',
                        style: TextStyle(
                          color: cMessageColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),),
                    ),

                    const SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(viewModel.menuResponse == null ? 'No Instructions' :
                      viewModel.menuResponse!.instructions ?? 'No Instructions',
                        style: const TextStyle(
                            color: Color(0xFF6C6C6C),
                            fontSize: 12,
                        ),),
                    ),

                    const SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [

                              IconButton(onPressed: (){
                                viewModel.minusItem();
                              },
                                  icon:  const Icon(Icons.remove_circle,
                                    color: cSelectedTabColor,
                                    size: 25,)),

                              Text(viewModel.totalItems.toString(),
                                style: const TextStyle(
                                    color: cTextColorBlack,
                                    fontSize: 14
                                ),),

                              IconButton(onPressed: (){
                                viewModel.addItem();
                              },
                                  icon:   const Icon(Icons.add_circle,
                                    color: cSelectedTabColor,
                                    size: 25,),),

                            ],
                          ),

                          Text('£ ${viewModel.totalPrice}',
                            style: const TextStyle(
                              color: Color(0xFF3E3E3E),
                              fontSize: 22,
                            ),),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: RaisedGradientButton(
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(color: Colors.white),
                        ),
                        gradient: const LinearGradient(
                          colors: <Color>[cButtonColor, cGradientColor2],
                        ),
                        onPressed: (){
                          viewModel.onClickAddToCart(context);
                        },
                        isBusy: viewModel.isBusy,
                      ),
                    ),

                    const SizedBox(height: 10,),

                  ],
                ),
              ),
            ),

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

  @override
  RestaurantMenuViewModel viewModelBuilder(BuildContext context){
    RestaurantMenuViewModel vm = RestaurantMenuViewModel();
    vm.getRestaurantMenu(context);
    return vm;
  }
}
