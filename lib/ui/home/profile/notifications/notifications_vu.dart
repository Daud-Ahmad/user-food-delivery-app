import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/loading_pages.dart';
import '../../../../models/notifications.dart';
import '../../../../styles.dart';
import 'notifications_vm.dart';

class NotificationsScreen extends ViewModelBuilderWidget<NotificationsViewModel> {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, NotificationsViewModel viewModel, Widget? child) {
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

                  const Text('Notifications',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Container(),
                ],
              ),
            ),

            viewModel.isBusy
                ? const Expanded(child: GettingRecords()) :
            viewModel.notificationsList.isEmpty ?
            const Expanded(child: NoRecord('You have no notifications yet',)) :
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: viewModel.notificationsList.length,
                    itemBuilder: (con, index) => notificationsListItem(viewModel.notificationsList[index])
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
              onTap: (){},
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

  Widget notificationsListItem(Notifications item){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width:46.0,
                  height: 46.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF865FD7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 3.0),
                        blurRadius: 19,
                      ),
                    ],
                  ),
                  child: Image.asset('assets/app_logo.png')
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),),

                      const SizedBox(height: 5,),

                      Text(item.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 12
                        ),),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10,),

          const Divider(
            color: Color(0xFFD8D8D8),
          ),
        ],
      ),
    );
  }

  @override
  NotificationsViewModel viewModelBuilder(BuildContext context)
  {
    NotificationsViewModel vm = NotificationsViewModel();
    vm.gettingNotifications(context);
    return vm;
  }
}
