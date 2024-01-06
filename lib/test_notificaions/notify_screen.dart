import 'dart:convert';

import 'package:chat_app/screens/all_chats/all_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotifyScreen extends StatefulWidget {
  static String id="NotifyScreen";
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  void getToken()async{
    String? token =await FirebaseMessaging.instance.getToken();
    print(token);
  }
  ///لما التطبيق يكون مقفول
  getInit()async{
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if(initialMessage.data['type']=="chat") {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllChatScreen(),));
      }
    }

  }
  @override
  void initState() {
    getToken();
    getInit();
    ///لما التطبيق يكون ف الباكجراوند وعايز الاشعار اللي هيوصل يفتح على اسكرين معينه
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   print("************************************");
    //   print('on message opened app');
    //   print(event.data.toString());
    //   if(event.data['type']=="chat") {
    //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllChatScreen(),));
    //   }
    //   print("************************************");
    // });

    ///when app open in background
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   // print('Got a message whilst in the foreground!');
    //   // print('==========================================');
    //   // print('Message data: ${message.data}');
    //   // print('=================================================');
    //
    //   if (message.notification != null) {
    //     print('=================================================');
    //     // print('Message data: ${message.data}');
    //     print(message.notification!.title);
    //     print(message.notification!.body);
    //     // print('Message also contained a notification: ${message.notification}');
    //     print('=================================================');
    //
    //
    //   }
    // });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MaterialButton(
        onPressed:()async{
         await sendMessage("notify", "how are you");
        } ,
        child: Text("send"),
      ),),
    );
  }

  sendMessage(title,message)async{
    var headers={
      "Accept":"*/*",
      "Content-Type":"application/json",
      "Authorization":"key=AAAA2K9vU-8:APA91bEvf5cQSdZFQUcZ00flx6-VtKnNqLz_GpI-_rzW-LJKJxoQ5IvJ5fh8NJh0aeAJYCiEu5S_H_VH3H72IvoxeYCKG5JXYQ2tjLZ-fRpHuSOp5i1er7QE8AXaPv63PKyBE-S0VQJT"
    };
    var url= Uri.parse("https://fcm.googleapis.com/fcm/send");
    var body={
      "to":"cu75cZiEQJ6-mKXKBL9YbK:APA91bFzDwaNQGPwd2bSG3CsaCb7LQYbCo_g9jXxigKyOL5GthQ4Onx_nSoTXR38ZYVAbjK5lG161OUSonvwH0lNi1cFNbXiXGMX1bUSXIuk5-W_Us7K2tw9Xz_5Lp5-xlV-2u2NW7lX",
      "notification":{
        "title":title,
        "body":message
      },
      "data": {
        "id":"1",
        "name":"ahmed",
        "hello": "world"
      }
    };
    var req=http.Request("POST",url);
    req.headers.addAll(headers);
    req.body=json.encode(body);
    var res= await req.send();
    final resBody=await res.stream.bytesToString();
    if(res.statusCode>=200 && res.statusCode<300){
      print(resBody);
    }else{
      print(res.reasonPhrase);
    }
  }
}
