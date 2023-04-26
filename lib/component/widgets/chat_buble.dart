
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

// ignore: must_be_immutable
class ChatBuble extends StatelessWidget {
   ChatBuble({required this.model,
    Key? key,
  }) : super(key: key);
MessageModel model;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child:Container(
        margin:const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 16,top:10  ,bottom:10,right:16  ),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )
        ),
        child: Text('${model.message}',
          style: const TextStyle(color: Colors.white,height: 1.5),),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({super.key,
    required this.model,
  });
  MessageModel model;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child:  Container(
        margin:const  EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 16,top:10 ,bottom:10,right:16  ),
        decoration: const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
        ),
        child: Text('${model.message}',
          style: const TextStyle(color: Colors.white,height: 1.5),),
      ),
    );
  }
}