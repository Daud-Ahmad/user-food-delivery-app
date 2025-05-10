import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../components/bottom_navigation_item_click.dart';
import '../../../components/images.dart';
import '../../../components/loading_pages.dart';
import '../../../config.dart';
import '../../../models/menu_type.dart';
import '../../../models/restaurant_list.dart';
import '../../../styles.dart';
import 'home_restaurant_list_vm.dart';

class HomeRestaurantListScreen extends ViewModelBuilderWidget<HomeRestaurantListViewModel> {
  const HomeRestaurantListScreen({Key? key}) : super(key: key);
  @override
  Widget builder(
      BuildContext context, HomeRestaurantListViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: cButtonColor,
            padding: const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 20),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,
                      color: Colors.white,),
                    ),
                    const SizedBox(width: 10,),
                    const Text('Delivery',
                    style: TextStyle(color: Colors.white),)
                  ],
                ),

                const SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Row(
                        children: const [
                          Icon(Icons.search,
                            color: cSelectedTabColor,),
                          SizedBox(width: 5,),
                          Expanded(child: SizedBox(
                            height: 40,
                            child: TextField(
                              cursorColor: cSelectedTabColor,
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search for restaurant, cuisine',
                              ),
                            ),
                          ))

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )
          ),
          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              height: 40,
              width: double.infinity,
              child: ListView.builder(
                itemCount: viewModel.menuTypeList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => mealTypeListItem(context,
                    viewModel, viewModel.menuTypeList[index], index),
              ),
            ),
          ),

          const SizedBox(height: 10,),

          viewModel.isBusy
              ? const Expanded(child: GettingRecords()) :
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Restaurant near you',
                          style: TextStyle(fontSize: 16,
                              color: Color(0xFF323232),
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        Text('see all',
                          style: TextStyle(fontSize: 12,
                              color: Color(0xFF666666)),),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      height: 210,
                      width: double.infinity,
                      child: viewModel.nearYouRestaurantsList.isEmpty ?
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: NoRecord('Restaurant not found near you',),
                      ) :
                      ListView.builder(
                        itemCount: viewModel.nearYouRestaurantsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => nearYouResListItem(context, viewModel, viewModel.nearYouRestaurantsList[index]),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Popular',
                          style: TextStyle(fontSize: 16,
                              color: Color(0xFF323232),
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        Text('see all',
                          style: TextStyle(fontSize: 12,
                              color: Color(0xFF666666)),),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: viewModel.popularRestaurantsList.isEmpty ?
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: NoRecord('Popular Restaurant not found near you',),
                      ) :
                      ListView.builder(
                        itemCount: viewModel.popularRestaurantsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => popularListItem(context, viewModel, viewModel.popularRestaurantsList[index]),
                      ),
                    ),
                  ),

                ],
              ),
            ),
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

  Widget nearYouResListItem(BuildContext context, HomeRestaurantListViewModel viewModel, Restaurant item){
    return GestureDetector(
      onTap: (){
        viewModel.onClickRestaurantDetail(context, item);
      },
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            Card(
              color: const Color(0xFF865FD7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SizedBox(
                height: 170,
                child: Stack(
                  children: [
                    CHINetworkImage(
                      AppConfig.imageBaseUrl + item.profileImage,
                      width: 300,
                      height: 170,
                    ),
                  ],
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child:   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(item.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Color(0xFF323232,),
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.star,
                          color: Color(0xFF865FD7),
                      size: 15,),
                      Text('${viewModel.getRating(item.rating)}  (${item.totalReviews ?? 0})',
                        style: const TextStyle(
                          color: Color(0xFF865FD7),
                            fontSize: 10,
                        ),
                      ),
                    ],
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget popularListItem(BuildContext context, HomeRestaurantListViewModel viewModel, Restaurant item){
    return GestureDetector(
      onTap: (){
        viewModel.onClickRestaurantDetail(context, item);
      },
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            Card(
              color: const Color(0xFF865FD7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CHINetworkImage(
                AppConfig.imageBaseUrl + item.profileImage,
                width: 300,
                height: 170,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mealTypeListItem(BuildContext context,
      HomeRestaurantListViewModel viewModel, MenuType item, int index){
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: (){
          viewModel.onClickMenuTypeListItem(context, index);
        },
        child: Container(
          width: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            color: item.isSelected ? const Color(0xFF865FD7) : const Color(0xFFE8EDF0),),
          child: Align(
            alignment: Alignment.center,
            child: Text(item.name,
              style: TextStyle(
                  color: item.isSelected ? Colors.white :  const Color(0xFF414141),
                  fontSize: 14
              ),),
          ),
        ),
      ),
    );
  }

  @override
  HomeRestaurantListViewModel viewModelBuilder(BuildContext context)
  {
    HomeRestaurantListViewModel vm = HomeRestaurantListViewModel();
    vm.getMenuTypeList(context);
    return vm;
  }
}
