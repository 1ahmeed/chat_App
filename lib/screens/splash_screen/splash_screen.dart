import 'package:chat_app/component/constant.dart';
import 'package:chat_app/screens/login/login_screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String id = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasySplashScreen(
        logo: Image.asset('assets/images/aa.png',),
        backgroundColor:kPrimaryColor ,
        durationInSeconds:3 ,
        logoWidth: 70,
        showLoader: false,
        navigator: LoginScreen(),
      ),

    );
  }
}