

import 'package:flutter/material.dart';

import '../../screens/login/login_screen.dart';
import '../cach_helper/shared_pref.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'uId').then((value){
    if(value==true){
      return  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);

      // NavigatorAndFinish( widget:LoginScreen());
    }
  });
}