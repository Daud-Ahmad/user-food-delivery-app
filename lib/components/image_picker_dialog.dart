import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';

Dialog imagePickerDialog (context, VoidCallback galleryPicker){

  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)), //this right here
    child: SizedBox(
      height: 200.0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: const Icon(CupertinoIcons.clear,
                  color: cButtonColor,)
            )
          ],
          title:  const Text('Image Picker',
            style: TextStyle(
              color: cButtonColor,
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            )),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             const Text('Complete action using',
             style: TextStyle(
               color: cButtonColor,
               fontSize: 20,
               fontStyle: FontStyle.normal,
               fontWeight: FontWeight.normal,
             )),

              const SizedBox(height: 20.0,),

              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                  galleryPicker();
                },

                child: Row(
                  children: const [
                    Icon(CupertinoIcons.photo,
                      size: 40.0,
                      color: cButtonColor,),

                    SizedBox(width: 10.0,),

                    Text('Gallery',
                      style: TextStyle(
                        color: cButtonColor,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ))
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    ),
  );
}

