import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../components/bottom_navigation_item_click.dart';
import '../../../../styles.dart';
import 'home_restaurant_filter_vm.dart';

class HomeRestaurantFilterScreen extends ViewModelBuilderWidget<HomeRestaurantFilterViewModel> {
  const HomeRestaurantFilterScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, HomeRestaurantFilterViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: cButtonColor,
            padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20, right: 20),
            child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.clear,
                color: Colors.white,),),
                const Text('Filter',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container()
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
                itemBuilder:(con, index) => favouriteListItem(viewModel, context)
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

  Widget favouriteListItem(HomeRestaurantFilterViewModel viewModel, BuildContext context){
    return InkWell(
      onTap: (){
        viewModel.onFavouriteListItemClick(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF865FD7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SizedBox(
                height: 170,
                width: double.infinity,
                child:  Image.asset('assets/img_favourite.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: 170,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('McDonalds - Wandsworth DT, UK',
                      style: TextStyle(
                        color: Color(0xFF323232,),
                        fontWeight: FontWeight.bold
                      ),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.star,
                              color: Color(0xFF865FD7)),
                          Text('4.3',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('(46)',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal
                            ),),
                        ],
                      )

                    ],
                  ),
                  const SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                    Text('Distance',
                      style: TextStyle(
                          color: Color(0xFF323232,),
                        fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),),
                    Text('Delivery',
                      style: TextStyle(
                          color: Color(0xFF797979,),
                        fontSize: 12
                      ),),
                  ],),
                  const SizedBox(height: 3,),
                  Row(
                    children: [
                      Container(
                        height: 26,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          color: viewModel.is2KmSelected ? const Color(0xFF865FD7) : const Color(0xFFE8EDF0),),
                        child: InkWell(
                          onTap: (){
                            viewModel.on2KmClick();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('2km',
                              style: TextStyle(
                                  color: viewModel.is2KmSelected ? Colors.white :  const Color(0xFF414141),
                                  fontSize: 12
                              ),),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Container(
                        height: 26,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          color: viewModel.is4kmSelected ? const Color(0xFF865FD7) : const Color(0xFFE8EDF0),),
                        child: InkWell(
                          onTap: (){
                            viewModel.on4KmClick();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('4km',
                              style: TextStyle(
                                  color: viewModel.is4kmSelected ? Colors.white :  const Color(0xFF414141),
                                  fontSize: 12
                              ),),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Container(
                        height: 26,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          color: viewModel.is6kmSelected ? const Color(0xFF865FD7) : const Color(0xFFE8EDF0),),
                        child: InkWell(
                          onTap: (){
                            viewModel.on6KmClick();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('6km',
                              style: TextStyle(
                                  color: viewModel.is6kmSelected ? Colors.white :  const Color(0xFF414141),
                                  fontSize: 12
                              ),),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Container(
                        height: 26,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          color: viewModel.is8kmSelected ? const Color(0xFF865FD7) : const Color(0xFFE8EDF0),),
                        child: InkWell(
                          onTap: (){
                            viewModel.on8KmClick();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('8km',
                              style: TextStyle(
                                  color: viewModel.is8kmSelected ? Colors.white :  const Color(0xFF414141),
                                  fontSize: 12
                              ),),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Container(
                        height: 26,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          color: viewModel.isOtherSelected ? const Color(0xFF865FD7) : const Color(0xFFE8EDF0),),
                        child: InkWell(
                          onTap: (){
                            viewModel.onOtherClick();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Other',
                              style: TextStyle(
                                  color: viewModel.isOtherSelected ? Colors.white :  const Color(0xFF414141),
                                  fontSize: 12
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  HomeRestaurantFilterViewModel viewModelBuilder(BuildContext context)
  {
    HomeRestaurantFilterViewModel vm = HomeRestaurantFilterViewModel();
    return vm;
  }
}
