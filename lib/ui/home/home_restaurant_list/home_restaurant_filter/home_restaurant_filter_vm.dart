import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class HomeRestaurantFilterViewModel extends BaseViewModel {

  bool is2KmSelected = true;
  bool is4kmSelected = false;
  bool is6kmSelected = false;
  bool is8kmSelected = false;
  bool isOtherSelected = false;
  int pageIndex = 0;

  onFavouriteListItemClick(BuildContext context){
    Navigator.pushNamed(context, '/restaurant_detail_screen');
  }

  on2KmClick(){
    if(!is2KmSelected){
      is2KmSelected = true;
      is4kmSelected = false;
      is6kmSelected = false;
      is8kmSelected = false;
      isOtherSelected = false;
      notifyListeners();
    }
  }

  on4KmClick(){
    if(!is4kmSelected){
      is2KmSelected = false;
      is4kmSelected = true;
      is6kmSelected = false;
      is8kmSelected = false;
      isOtherSelected = false;
      notifyListeners();
    }
  }

  on6KmClick(){
    if(!is6kmSelected){
      is2KmSelected = false;
      is4kmSelected = false;
      is6kmSelected = true;
      is8kmSelected = false;
      isOtherSelected = false;
      notifyListeners();
    }
  }

  on8KmClick(){
    if(!is8kmSelected){
      is2KmSelected = false;
      is4kmSelected = false;
      is6kmSelected = false;
      is8kmSelected = true;
      isOtherSelected = false;
      notifyListeners();
    }
  }

  onOtherClick(){
    if(!isOtherSelected){
      is2KmSelected = false;
      is4kmSelected = false;
      is6kmSelected = false;
      is8kmSelected = false;
      isOtherSelected = true;
      notifyListeners();
    }
  }

}
