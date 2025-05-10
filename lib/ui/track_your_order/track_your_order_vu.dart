import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../styles.dart';
import 'track_your_order.dart';

class TrackYourOrderScreen extends ViewModelBuilderWidget<TrackYourOrderViewModel> {
  const TrackYourOrderScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TrackYourOrderViewModel viewModel, Widget? child) {
    return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.asset(
                'assets/img_map_one.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Column(
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

                        const Text('Track your orders',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        Container()
                      ],
                    )
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset('assets/img_circle_home.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, right: 100),
                    child: Image.asset('assets/img_circle_flag.png'),
                  ),
                ],),

                Expanded(child: Container()),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: const [
                                Icon(Icons.access_time_rounded,
                                color: Color(0xFF8F70D3),),
                                SizedBox(width: 5,),
                                Text('18 min',
                                style: TextStyle(
                                  color: Color(0xFF555454),
                                  fontSize: 14
                                ),)
                              ],),
                              const Divider(color: Color(0xFFE4E4E4),),
                              Row(children: [
                                Container(
                                    width:20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: cSelectedTabColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(0, 3.0),
                                          blurRadius: 19,
                                        ),
                                      ],
                                    ),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('1',
                                          style: TextStyle(color: Colors.white),))
                                ),
                                const SizedBox(width: 5,),
                                const Text('Your order has been received',
                                  style: TextStyle(
                                      color: Color(0xFF737272),
                                      fontSize: 14
                                  ),)
                              ],),

                              const SizedBox(height: 20,),

                              Row(children: [
                                Container(
                                    width:20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFFD1D0D3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(0, 3.0),
                                          blurRadius: 19,
                                        ),
                                      ],
                                    ),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('2',
                                          style: TextStyle(color: Colors.white),))
                                ),
                                const SizedBox(width: 5,),
                                const Text('The restaurant is preparing your food',
                                  style: TextStyle(
                                      color: Color(0xFF737272),
                                      fontSize: 14
                                  ),)
                              ],),

                              const SizedBox(height: 10,),

                              const Divider(color: Color(0xFFE4E4E4),),

                              const SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Row(children: const [
                                  Icon(Icons.location_on_outlined,
                                    color: Color(0xFF8F70D3),),
                                  SizedBox(width: 5,),
                                  Text('59 St. John’s Road',
                                    style: TextStyle(
                                        color: Color(0xFF737272),
                                        fontSize: 14
                                    ),)
                                ],),
                                  const Text('£ 24.45',
                                    style: TextStyle(
                                        color: Color(0xFF737272),
                                        fontSize: 14
                                    ),)
                                ],),

                            ],
                          ),
                        )
                    ),
                  ),
                ),

                const SizedBox(height: 40,),

              ],
            ),
          ],
        ),


    );
  }

  @override
  TrackYourOrderViewModel viewModelBuilder(BuildContext context) => TrackYourOrderViewModel();
}
