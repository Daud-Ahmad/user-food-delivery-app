import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';

import '../../components/images.dart';
import '../../components/raised_gradient_button.dart';
import '../../config.dart';
import '../../styles.dart';
import 'get_rating_vm.dart';

class GetRatingScreen extends ViewModelBuilderWidget<GetRatingViewModel> {
  const GetRatingScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, GetRatingViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: double.infinity,
                color: cButtonColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, right: 10, bottom: 10),
                  child:    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        viewModel.onClickSkipRating(context);
                      },
                        icon: const Icon(Icons.arrow_back,
                          color: Colors.white,),),


                      const Text('Feedback',
                        style: TextStyle(color: Colors.white,
                            fontSize: 14),),

                      const Text('',
                        style: TextStyle(color: Colors.white,
                            fontSize: 14),)
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('You have completed order. Please give Feedback to Prepper of your experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: cMessageColor,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Prepper Details',
                  style: TextStyle(
                      color: cMessageColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              width:80.0,
                              height: 80.0,
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
                              child: CHINetworkImage(
                                viewModel.orderDetailResp == null ? '...' :
                                AppConfig.imageBaseUrl + viewModel.orderDetailResp!.preperDetail!.profileImage,
                                width: 50,
                                height: 50,
                              ),
                            ),

                            Expanded(child:
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(viewModel.orderDetailResp == null ? '...' :
                                  viewModel.orderDetailResp!.preperDetail!.name,
                                    style: const TextStyle(
                                        color: cMessageColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                  const SizedBox(height: 5,),

                                  Text(viewModel.orderDetailResp == null ? '...' :
                                  viewModel.orderDetailResp!.preperDetail!.email,
                                    style: const TextStyle(
                                      color: Color(0xFF676767),
                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(height: 5,),

                                  Text(viewModel.orderDetailResp == null ? '...' :
                                  viewModel.orderDetailResp!.preperDetail!.phone,
                                    style: const TextStyle(
                                      color: Color(0xFF3481F5),
                                      fontSize: 12,
                                    ),
                                  ),

                                ],
                              ),
                            ))
                          ],
                        )
                    )
                ),
              ),

              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Order Details',
                  style: TextStyle(
                      color: cMessageColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('Booking ID : #${viewModel.orderDetailResp!.id}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF747474)
                              ),
                            ),

                            const SizedBox(height: 10,),

                            const Text('Menu',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: cMessageColor
                              ),
                            ),

                            const SizedBox(height: 5,),


                            Text(viewModel.gettingMenuNameAndQuantity(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: cMessageColor
                              ),
                            ),

                            const SizedBox(height: 10,),

                            const Text('Delivered',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: cMessageColor
                              ),
                            ),

                            const SizedBox(height: 5,),

                            Text('${viewModel.orderDetailResp!.pickupDeliveryDate} from ${viewModel.orderDetailResp!.startTime}'
                                ' To ${viewModel.orderDetailResp!.endTime}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: cMessageColor
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ),


              const SizedBox(height: 20,),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Feedback',
                  style: TextStyle(
                      color: cMessageColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('How was the experience?',
                  style: TextStyle(
                      color: cMessageColor,
                      fontSize: 14,
                  ),
                ),
              ),

          const SizedBox(height: 10,),

          Center(
            child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: cButtonColor,
              ),
              onRatingUpdate: (rating) {
                viewModel.userRating = rating;
              },),
          ),

              const SizedBox(height: 20,),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Give some feedback in word',
                  style: TextStyle(
                    color: cMessageColor,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  validator: viewModel.feedbackValidator,
                  decoration: InputStyles.getDescriptionInput(
                      hint: 'Enter Feedback'),
                  onSaved: (String? value) {
                    viewModel.inputFeedback(value);
                  },
                  controller: TextEditingController(text: viewModel.feedBack),
                  style: const TextStyle(color: Colors.black),

                ),
              ),

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child:  InkWell(
                        onTap: (){
                          viewModel.onClickSkipRating(context);
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF7D52DC)),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(40.0) //                 <--- border radius here
                            ),
                          ),
                          child: const Center(
                            child: Text('Skip',
                              style: TextStyle(
                                  color: Color(0xFF7D52DC),
                                  fontSize: 12
                              ),),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10,),

                    Expanded(
                      child: RaisedGradientButton(
                        gradient: const LinearGradient(
                          colors: <Color>[cButtonColor, cGradientColor2],
                        ),
                        onPressed: (){
                          viewModel.onClickSubmit(context);
                        },
                        height: 50,
                        isBusy: viewModel.isBusy,
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  @override
  GetRatingViewModel viewModelBuilder(BuildContext context) {
    GetRatingViewModel vm = GetRatingViewModel();
    vm.getOrderDetail(context);
    return vm;
  }
}
