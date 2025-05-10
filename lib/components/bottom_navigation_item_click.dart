

import 'package:flutter/cupertino.dart';
import 'package:mura_user_app/components/show_login_bottom_sheet.dart';

import '../preferences.dart';

onBottomNavigationBarItemClick(BuildContext context, int index) async{
  if(index == 1 || index == 2 || index == 4){
    final token = await Preferences.getKey(Preferences.kToken);
    if(token == null){
      showCLoginBottomSheet(context);
      return;
    }
  }
  Navigator.pushNamedAndRemoveUntil(context, '/home_screen',(r) => false, arguments: index);
}