import 'package:chat_app/layout/layout_screen.dart';
import 'package:chat_app/screens/all_chats/all_chat_screen.dart';
import 'package:chat_app/screens/login/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/login/login_screen.dart';
import 'package:chat_app/screens/register/register_cubit/register_cubit.dart';
import 'package:chat_app/screens/register/register_screen.dart';
import 'package:chat_app/screens/splash_screen/splash_screen.dart';
import 'package:chat_app/test_notificaions/notify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'component/cach_helper/shared_pref.dart';
import 'component/constant.dart';
import 'firebase_options.dart';
import 'layout/chat_cubit/chat_cubit.dart';
import 'otp/phone_screen.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
// print("-------------------------------------");
// print('Message data: ${message.data}');
//   print(message.notification!.title);
//   print(message.notification!.body);
// print("-------------------------------------");
//
//   // print("Handling a background message: ${message.messageId}");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? token =await FirebaseMessaging.instance.getToken();
  print(token);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   // print('Got a message whilst in the foreground!');
  //
  //   if (message.notification != null) {
  //     print('=================================================');
  //      print('Message data: ${message.data}');
  //     print(message.notification!.title);
  //     print(message.notification!.body);
  //     // print('Message also contained a notification: ${message.notification}');
  //     print('=================================================');
  //
  //
  //   }
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print("************************************");
  //   print('on message opened app');
  //   print(event.data.toString());
  //   print("************************************");
  // });
  ///لما التطبيق يكون background
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
          NotifyScreen.id: (context) => const NotifyScreen(),
        },
        initialRoute: startWidget,
        // home: Phone(),
      ),
    );
  }
}
