import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../screens/chat/chat_details_screen.dart';

// ignore: must_be_immutable
class ChatItem extends StatelessWidget {
   ChatItem( {super.key, required this.model, });

    UserModel? model;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ChatDetailsScreen(userModel: model),));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    '${model!.image}'
                ),
              ),
              const SizedBox(width: 10,),
              Text(
                '${model!.name}',
                style:const  TextStyle(height: 1.4),
              ),

            ]
        ),
      ),
    );
  }
}
