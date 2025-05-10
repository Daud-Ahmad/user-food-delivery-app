import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../../components/raised_gradient_button.dart';
import '../../../../../styles.dart';
import 'orders_list_vm.dart';

class OrdersListScreen extends ViewModelBuilderWidget<OrdersListViewModel> {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, OrdersListViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap:(){
                Navigator.pop(context);
              },
              child: const Icon(Icons.clear,
              color: Colors.black,),
            ),

            const SizedBox(height: 20,),

             const Align(
               alignment: Alignment.center,
               child: Text('Subscription Service',
                style: TextStyle(
                    color: cMessageColor,
                    fontSize: 20
                ),),
             ),

            const SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 20),
              child:    Card(
                color: const Color(0xFF8660D8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                    child: Text('Active Orders',
                      style:  TextStyle(
                          color: Colors.white,
                          fontSize: 12
                      ),),
                  ),
                ),
              ),
            ),

            Expanded(child:
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: ListView.builder(
                itemCount: 3,
                  itemBuilder: (con, index) => ordersListItem()
              ),
            )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: double.infinity,
                height: 45.0,
                child: RaisedGradientButton(
                  child: const Text(
                    'Help & Sport',
                    style: TextStyle(color: Colors.white),
                  ),
                  gradient: const LinearGradient(
                    colors: <Color>[cButtonColor, cGradientColor2],
                  ),
                  onPressed: (){
                    viewModel.onClickHelpAndSport(context);
                  },
                  isBusy: viewModel.isBusy,
                ),
              ),
            ),

            const SizedBox(height: 20,),

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

  Widget ordersListItem(){
    return Card(
      color: const Color(0xFFF1F1F1),
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

              const Text('Order 1',
                style:  TextStyle(
                    color: cMessageColor,
                    fontSize: 14
                ),),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Creamy Chickpea Spaghetti',
                    style:  TextStyle(
                        color: cMessageColor,
                        fontSize: 16
                    ),),
                  SizedBox(height: 5,),
                  Text('Creamy Chickpea Spaghetti blaaa blaa blaaa blaa blaaa blaa blaa blaa',
                    style:  TextStyle(
                        color: cMessageColor,
                        fontSize: 12
                    ),),

                ],
              ),

              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [

                    Text('Order Places\n16 March 2021',
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                          color: cMessageColor,
                          fontSize: 12
                      ),),

                    Text('Total\n3,27',
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                          color: cMessageColor,
                          fontSize: 12
                      ),),

                    Text('Order ID\n12345678',
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                          color: cMessageColor,
                          fontSize: 12
                      ),),

                  ],
                ),
              ),

              const SizedBox(height: 5,),

            ],
          ),
        )
      ),
    );

  }

  @override
  OrdersListViewModel viewModelBuilder(BuildContext context) {
    final vm = OrdersListViewModel();
    return vm;
  }
}
