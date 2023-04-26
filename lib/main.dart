import 'package:chat_app/layout/layout_screen.dart';
import 'package:chat_app/screens/all_chats/all_chat_screen.dart';
import 'package:chat_app/screens/login/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/login/login_screen.dart';
import 'package:chat_app/screens/register/register_cubit/register_cubit.dart';
import 'package:chat_app/screens/register/register_screen.dart';
import 'package:chat_app/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'component/cach_helper/shared_pref.dart';
import 'component/constant.dart';
import 'firebase_options.dart';
import 'layout/chat_cubit/chat_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

  String widget;
  uId = CacheHelper.getData(key: "uId");
  print("token");
  print(uId);
  if (uId != null) {
    widget = LayoutScreen.id;
  } else {
    widget = SplashScreen.id;
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final String? startWidget;

  const MyApp({super.key, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit()
        ),
        BlocProvider(
          create: (context) => ChatCubit()..getUserData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          LayoutScreen.id: (context) => const LayoutScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          AllChatScreen.id: (context) => const AllChatScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
        },
        initialRoute: startWidget,
      ),
    );
  }
}
