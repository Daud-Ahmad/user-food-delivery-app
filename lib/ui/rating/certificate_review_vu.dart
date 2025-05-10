import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';

import '../../components/loading_pages.dart';
import '../../models/reviews.dart';
import '../../styles.dart';
import 'certificate_review_vm.dart';

class CertificateReviewScreen extends ViewModelBuilderWidget<CertificateReviewViewModel> {
  const CertificateReviewScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, CertificateReviewViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
              width: double.infinity,
              color: cButtonColor,
              padding: const EdgeInsets.only(top: 60, left: 15, right: 15, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back,
                      color: Colors.white,),
                  ),
                  const Text('Reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,),),

                  const Text('',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,),)
                ],
              ),
          ),

          const SizedBox(height: 20,),

          Expanded(
            child:
            viewModel.isBusy
                ? const GettingRecords() :
    viewModel.reviewsList.isEmpty ? const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: NoRecord('Restaurant Have no rating yet'),) :
    ListView.builder(
                itemCount: viewModel.reviewsList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (con, index) => reviewListItem(viewModel, context, viewModel.reviewsList[index])
            )
          ),

        ],
      ),
    );
  }

  Widget reviewListItem(CertificateReviewViewModel viewModel,
      BuildContext context, Reviews item){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width:36.0,
                height: 36.0,
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
                child: const Icon(
                  Icons.person,
                  size: 14,
                ),
              ),

              const SizedBox(width: 10,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.userDetail!.name,
                    style: const TextStyle(
                        color: cTextColorBlack,
                        fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),

                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: double.parse(item.rating),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                        itemSize: 15,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: cButtonColor,),
                        ignoreGestures: true,
                        onRatingUpdate: (rating) {
                        },
                      ),

                      const SizedBox(width: 5,),

                      Text('(${viewModel.getRating(item.rating)})',
                        style: const TextStyle(
                            color: cTextColorBlack,
                            fontSize: 15,
                        ),),

                    ],
                  ),
                ],
              ),

            ],
          ),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(item.review,
              style: const TextStyle(
                color: cTextColorBlack,
                fontSize: 15,
              ),),
          ),

          const SizedBox(height: 10,),

          const Divider(color: cMessageColor),

          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  @override
  CertificateReviewViewModel viewModelBuilder(BuildContext context) {
    CertificateReviewViewModel vm = CertificateReviewViewModel();
    vm.getRestaurantId(context);
    return vm;
  }
}
