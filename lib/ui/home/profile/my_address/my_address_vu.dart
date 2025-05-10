import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/raised_gradient_button.dart';
import '../../../../styles.dart';
import 'my_address_vm.dart';

class MyAddressScreen extends ViewModelBuilderWidget<MyAddressViewModel> {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, MyAddressViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Image.asset('assets/map_image.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

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

                    const Text('Add a new Address',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    Container(),
                  ],
                ),
              ),

              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                  child: Column(
                    children: [

                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('78 Alexander Road, London',
                            style: TextStyle(
                                color: Color(0xFF3C3C3C),
                                fontSize: 14
                            ),),
                          Icon(Icons.my_location_sharp,
                          color: cSelectedTabColor,),
                        ],
                      ),

                      const SizedBox(height: 10,),

                      const Divider(color: Color(0xFFD8D8D8),),

                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.search,
                            color: cSelectedTabColor,),

                          SizedBox(width: 10,),

                          Text('647 Victoria Road, London',
                            style: TextStyle(
                                color: Color(0xFF3C3C3C),
                                fontSize: 14
                            ),),
                        ],
                      ),

                      const Divider(color: Color(0xFFD8D8D8),),

                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.search,
                            color: cSelectedTabColor,),

                          SizedBox(width: 10,),

                          Text('647 Victoria Road, London',
                            style: TextStyle(
                                color: Color(0xFF3C3C3C),
                                fontSize: 14
                            ),),
                        ],
                      ),

                      const Divider(color: Color(0xFFD8D8D8),),

                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.search,
                            color: cSelectedTabColor,),

                          SizedBox(width: 10,),

                          Text('647 Victoria Road, London',
                            style: TextStyle(
                                color: Color(0xFF3C3C3C),
                                fontSize: 14
                            ),),
                        ],
                      ),

                      const Divider(color: Color(0xFFD8D8D8),),

                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.search,
                            color: cSelectedTabColor,),

                          SizedBox(width: 10,),

                          Text('647 Victoria Road, London',
                            style: TextStyle(
                                color: Color(0xFF3C3C3C),
                                fontSize: 14
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(child: Container()),

              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40, bottom: 30),
                child: RaisedGradientButton(
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                  gradient: const LinearGradient(
                    colors: <Color>[cButtonColor, cGradientColor2],
                  ),
                  onPressed: (){
                  },
                  isBusy: viewModel.isBusy,
                ),
              ),

            ],
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

  @override
  MyAddressViewModel viewModelBuilder(BuildContext context) {
    final vm = MyAddressViewModel();
    return vm;
  }
}
