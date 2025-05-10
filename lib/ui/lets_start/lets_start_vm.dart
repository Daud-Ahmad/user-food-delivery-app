import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LetsStartViewModel extends BaseViewModel {

  int showImageIndex = 0;

  onLetsStartClick(BuildContext context){
    switch(showImageIndex){
      case 0 :
        ++showImageIndex;
        break;
      case 1 :
        ++showImageIndex;
        break;
      case 2 :
        Navigator.pushReplacementNamed(context, '/home_screen', arguments: 0);
        break;
    }

    notifyListeners();
  }
}
