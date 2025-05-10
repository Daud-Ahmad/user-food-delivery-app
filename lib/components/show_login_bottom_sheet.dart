
import 'dart:io';

import 'package:flutter/material.dart';

import '../preferences.dart';
import '../styles.dart';

showCLoginBottomSheet(BuildContext context){
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 300.0,
          color: const Color(0xFF737373),
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Sign In or Sign Up',
                      style: TextStyle(color: Color(0xFF302F2F),
                          fontSize: 20),
                    ),

                    const SizedBox(height: 20,),

                    Visibility(
                      visible: Platform.isIOS,
                      child: InkWell(
                        onTap: ()async{
                          await Preferences.setKey(Preferences.kIsUserAsGuest, "");
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/login_screen', (Route<dynamic> route) => false);
                        },
                        child: Container(
                            width: double.infinity,
                            height: 45.0,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(30.0)
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/apple_logo.png',
                                  height: 50,
                                  width: 50,),
                                const Text('Sign in with Apple',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),)
                              ],
                            )
                        ),
                      ),
                    ),

                    Visibility(
                        visible: Platform.isIOS,
                        child: const SizedBox(height: 10,)),

                    InkWell(
                      onTap: ()async{
                        await Preferences.setKey(Preferences.kIsUserAsGuest, "");
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/login_screen', (Route<dynamic> route) => false);
                      },
                      child: Container(
                          width: double.infinity,
                          height: 45.0,
                          decoration: const BoxDecoration(
                              color: Color(0xFFEC4235),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset('assets/google_logo.png',
                                  height: 50,
                                  width: 50,),
                              ),
                              const Text('with Google',
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 15,),
                              )
                            ],
                          )
                      ),
                    ),

                    const SizedBox(height: 10,),

                    const Align(
                      alignment: Alignment.center,
                      child: Text('OR',
                        style: TextStyle(
                            color: cBlack50,
                            fontSize: 14
                        ),),
                    ),

                    const SizedBox(height: 10,),

                    SizedBox(
                        width: double.infinity,
                        height: 45.0,
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                              border: Border.all(color: const Color(0xFF8660D8))
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: ()async{
                                  await Preferences.setKey(Preferences.kIsUserAsGuest, "");
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/login_screen', (Route<dynamic> route) => false);
                                },
                                child: const Center(
                                  child:Text('Continue with email',
                                    style: TextStyle(color: cSelectedTabColor,
                                        fontSize: 14),),
                                )),
                          ),
                        )
                    ),
                  ],
                ),
              )
          ),
        );
      });

}