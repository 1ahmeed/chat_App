import 'package:chat_app/component/widgets/image_in_chat.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/constant.dart';
import '../../component/widgets/show_toast.dart';
import '../../component/widgets/chat_buble.dart';
import '../../layout/chat_cubit/chat_cubit.dart';
import '../../layout/chat_cubit/chat_state.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;

  ChatDetailsScreen({super.key, this.userModel});

  static String id = 'ChatScreen';
  var messageController = TextEditingController();
  final controller = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ChatCubit.get(context)?.getMessages(receiverId: userModel!.uId!);
      return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {
          if(state is ChatUploadImageInChatSuccessState) {
            showToast(text: "Upload Successfully", state: ToastStates.success);

          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              elevation: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${userModel?.image}'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${userModel?.name}',
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemBuilder: (context, index) {
                      var messageList =
                          ChatCubit.get(context)?.showMessages[index];
                      if (uId == messageList!.senderId) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 90.0),
                          child: Column(
                            children: [
                              if (messageList.image == null &&
                                  messageList.message != "")
                                ChatBuble(model: messageList),
                              if (messageList.image != null &&
                                  messageList.message == "")
                                ImageBuble(
                                  model: messageList,
                                ),
                              if (messageList.image != null &&
                                  messageList.message != "")
                                ImageBuble(
                                  model: messageList,
                                ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(right: 90.0),
                          child: Column(
                            children: [
                              if (messageList.image == null &&
                                  messageList.message != "")
                                ChatBubleForFriend(model: messageList),
                              if (messageList.image != null &&
                                  messageList.message == "")
                                ImageBubleForFriend(
                                  model: messageList,
                                ),
                              if (messageList.image != null &&
                                  messageList.message != "")
                                ImageBubleForFriend(
                                  model: messageList,
                                ),
                            ],
                          ),
                        );
                      }
                    },
                    itemCount: ChatCubit.get(context)!.showMessages.length,
                  )),
                  if (ChatCubit.get(context)!.imageInChat != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                            image:
                                FileImage(ChatCubit.get(context)!.imageInChat!),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, right: 5.0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: kPrimaryColor,
                            child: IconButton(
                                onPressed: () {
                                  ChatCubit.get(context)?.removeImageChat();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 15,
                                )),
                          ),
                        )
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: messageController,
                      validator: (value) {
                        if (value!.isNotEmpty ||
                            ChatCubit.get(context)!.imageInChatString != null) {
                          return null;
                        } else {
                          return "";
                        }
                      },
                      maxLines: 100,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Send Message",
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (ChatCubit.get(context)!.imageInChat != null)
                              TextButton(
                                  onPressed: () {
                                    ChatCubit.get(context)!.uploadImageInChat();
                                  },
                                  child: const Text('Upload')),
                            if (ChatCubit.get(context)!.imageInChat != null)
                              const SizedBox(
                                width: 10,
                              ),
                            InkWell(
                                onTap: () {
                                  ChatCubit.get(context)!.getImageInChat();
                                },
                                child: const Icon(Icons.image)),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate() ||
                                    ChatCubit.get(context)!.imageInChatString !=
                                        null) {
                                  ChatCubit.get(context)?.sendMessages(
                                      dateTime: DateTime.now().toString(),
                                      message: messageController.text,
                                      receiverId: userModel!.uId!,
                                      image: ChatCubit.get(context)!
                                          .imageInChatString);

                                  ChatCubit.get(context)!.removeImageChat();
                                  messageController.clear();
                                  controller.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.send,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
