import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

// ignore: must_be_immutable
class ImageBuble extends StatelessWidget {
  ImageBuble({super.key, required this.model,
  }) ;
  MessageModel model;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if(model.message !="")
              Container(
                padding: const EdgeInsets.only(left: 16,top:16 ,bottom:16,right:16  ),
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
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
              ),
              child: Image.network('${model.image}',),
            ),
          ],
        ),
      )
        );
  }
}

// ignore: must_be_immutable
class ImageBubleForFriend extends StatelessWidget {
  ImageBubleForFriend({super.key,
    required this.model,
  });
  MessageModel model;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(model.message !="")
              Container(
                padding: const EdgeInsets.only(left: 16,top:16 ,bottom:16,right:16  ),
                decoration: const BoxDecoration(
                    color: Color(0xff006D84),
                    borderRadius: BorderRadius.only(
                     bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                ),
                child: Text('${model.message}',
                  style: const TextStyle(color: Colors.white,height: 1.5),),
              ),

            Image.network('${model.image}'),
          ],
        ),
      ),
    );
  }
}