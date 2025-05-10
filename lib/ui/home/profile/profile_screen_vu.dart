import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:stacked/stacked.dart';

import '../../../styles.dart';
import 'profile_screen_vm.dart';

class TabProfileScreen extends ViewModelBuilderWidget<ProfileScreenViewModel> {
  const TabProfileScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ProfileScreenViewModel viewModel, Widget? child) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: cButtonColor,
                padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20, right: 20),
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const Text('Profile',
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

              const SizedBox(height: 30,),

              InkWell(
                onTap: (){
                  viewModel.onEditProfileClick(context);
                },
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                        Text(viewModel.userName == null ? '...' : '${viewModel.userName}',
                          style: const TextStyle(
                              color: cTextColorBlack,
                              fontSize: 14
                          ),),

                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      child: Text('Edit',
                        style: TextStyle(
                            color: cSelectedTabColor,
                            fontSize: 14
                        ),),
                    ),
                  ],
                ),
            ),
          ),
      ),
              ),

              const SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  viewModel.onNotificationClick(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child: Row(
                        children: const [
                          Icon(Icons.notifications_active_outlined),

                          SizedBox(width: 10,),

                          Text('Notifications',
                            style: TextStyle(
                                color: cTextColorBlack,
                                fontSize: 14
                            ),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  viewModel.onChangePasswordClick(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child : Row(
                        children: const [
                          Icon(Icons.lock_outline),

                          SizedBox(width: 10,),

                          Text('Change Password',
                            style: TextStyle(
                                color: cTextColorBlack,
                                fontSize: 14
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  viewModel.onClickMyAddress(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child : Row(
                        children: const [
                          Icon(Icons.location_on_outlined),

                          SizedBox(width: 10,),

                          Text('My Address',
                            style: TextStyle(
                                color: cTextColorBlack,
                                fontSize: 14
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  viewModel.onClickApply(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child : Row(
                        children: const [
                          Icon(Icons.payment),

                          SizedBox(width: 10,),

                          Text('My Payment Method',
                            style: TextStyle(
                                color: cTextColorBlack,
                                fontSize: 14
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // const SizedBox(height: 10,),
              //
              // InkWell(
              //   onTap: (){
              //     viewModel.onSubscriptionClick(context);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              //     child: Card(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              //         child : Row(
              //           children: [
              //             Image.asset('assets/crown_icon.png',
              //             color: Colors.black,
              //             width: 20,
              //             height: 20,),
              //
              //             const SizedBox(width: 10,),
              //
              //             const Text('Subscription',
              //               style: TextStyle(
              //                   color: cTextColorBlack,
              //                   fontSize: 14
              //               ),),
              //
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  viewModel.onClickContactUs(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child : Row(
                        children: const [
                          Icon(Icons.chat),

                          SizedBox(width: 10,),

                          Text('Chat us',
                            style: TextStyle(
                                color: cTextColorBlack,
                                fontSize: 14
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  viewModel.onClickLogOut(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child : Row(
                        children: const [
                          Icon(Icons.logout),

                          SizedBox(width: 10,),

                          Text('Logout',
                            style: TextStyle(
                                color: cTextColorBlack,
                                fontSize: 14
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  viewModel.onClickDeleteAccount(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child : Row(
                        children: const [
                          Icon(Icons.delete_forever),
                          SizedBox(width: 10,),
                          Text('Delete Account',
                            style: TextStyle(
                                color: cTextColorBlack,
                                fontSize: 14
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                    child : Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [

                              Text('NOTIFICATIONS',
                                style: TextStyle(
                                    color: cTextColorBlack,
                                    fontSize: 14
                                ),),

                              SizedBox(height: 5,),

                              Text('I would like to receive the progress of my orders',
                                style: TextStyle(
                                    color: cTextColorBlack,
                                    fontSize: 12
                                ),),

                            ],
                          ),
                        ),

                        FlutterSwitch(
                          width: 50,
                          height: 25.0,
                          valueFontSize: 25.0,
                          toggleSize: 22.0,
                          toggleColor: cSelectedTabColor,
                          value: viewModel.status,
                          activeColor: cGradientColor2,
                          inactiveColor: const Color(0xffA8A8A8),
                          borderRadius: 30.0,
                          padding: 2.0,
                          onToggle: (val) {
                            viewModel.status = val;
                            viewModel.notifyListeners();
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        )

    );
  }

  @override
  ProfileScreenViewModel viewModelBuilder(BuildContext context)
  {
    ProfileScreenViewModel vm = ProfileScreenViewModel();
    vm.getUserName();
    return vm;
  }
}
