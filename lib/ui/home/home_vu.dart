import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../styles.dart';
import 'home_vm.dart';

class HomeScreen extends ViewModelBuilderWidget<HomeViewModel> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: viewModel.tabs[viewModel.pageIndex],
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
                viewModel.onClickBottomTab(0, context);
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
                viewModel.onClickBottomTab(1, context);
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
                viewModel.onClickBottomTab(2, context);
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
                viewModel.onClickBottomTab(3, context);
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
                viewModel.onClickBottomTab(4, context);
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
  HomeViewModel viewModelBuilder(BuildContext context)
  {
    HomeViewModel vm = HomeViewModel();
    vm.getIndex(context);
    return vm;
  }
}
