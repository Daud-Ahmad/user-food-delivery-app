import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../components/images.dart';
import '../../../components/loading_pages.dart';
import '../../../config.dart';
import '../../../models/favourite_restaurant.dart';
import '../../../styles.dart';
import 'favourite_vm.dart';

class TabFavouriteScreen extends ViewModelBuilderWidget<TabHomeFavouriteViewModel> {
  const TabFavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TabHomeFavouriteViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: cButtonColor,
            padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20),
            child:   const Center(
              child: Text('Favourites',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Expanded(
            child:
            viewModel.isBusy
                ? const GettingRecords() :
            viewModel.favouriteRestaurant.isEmpty ?
            const NoRecord('Favourite Restaurant not found',) :
            ListView.builder(
              itemCount: viewModel.favouriteRestaurant.length,
                itemBuilder:(con, index) => favouriteListItem(viewModel, context,
                    viewModel.favouriteRestaurant[index])
            ),
          )

        ],
      )

    );
  }

  Widget favouriteListItem(TabHomeFavouriteViewModel viewModel,
      BuildContext context, FavouriteRestaurant item){
    return InkWell(
      onTap: (){
        viewModel.onFavouriteListItemClick(context, item);
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
                child: CHINetworkImage(
                  AppConfig.imageBaseUrl + item.profileImage,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: 170,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name,
                    style: const TextStyle(
                        color: Color(0xFF323232,),
                        fontWeight: FontWeight.bold
                    ),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.star,
                          color: Color(0xFF865FD7)),
                      Text('${viewModel.getRating(item.rating)}  (${item.totalReviews ?? 0})',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
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

  @override
  TabHomeFavouriteViewModel viewModelBuilder(BuildContext context)
  {
    TabHomeFavouriteViewModel vm = TabHomeFavouriteViewModel();
    vm.gettingFavouriteRestaurantList(context);
    return vm;
  }
}
