import 'dart:io';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screens/all_chats/all_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../component/constant.dart';
import '../../models/user_model.dart';
import '../../screens/profile/setting_screen.dart';
import 'chat_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit? get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titles = [
    'Chats',
    'Profile',
  ];
  List<Widget> screens = [
    const AllChatScreen(),
    ProfileScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChatBottomNavBarState());
  }

  UserModel? userModel;

  void sendMessages({
    required String message,
    required String receiverId,
    required String dateTime,
    String? image,
  }) {
    MessageModel model = MessageModel(
        dateTime: dateTime,
        message: message,
        receiverId: receiverId,
        senderId: uId,
        image: imageInChatString);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatSendMessageErrorState());
    });
  }

  List<MessageModel> showMessages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      showMessages.clear();
      //event.docs.forEach((element)
      for (var element in event.docs) {
        showMessages.add(MessageModel.fromJson(element.data()));
      }
      emit(ChatGetMessagesSuccessState());
    });
  }

  List<UserModel>? users = [];
  void getUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      //value.docs.forEach((element)
      for (var element in value.docs) {
        if (element.data()['uId'] != uId) {
          users!.add(UserModel.fromJson(element.data()));
        }
      }
      emit(ChatGetAllUserSuccessState());
    }).catchError((error) {
      emit(ChatGetAllUserErrorState(error));
    });
  }

  void getUserData() {
    emit(ChatGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      //print(userModel!.name);
      emit(ChatGetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChatGetUserDataErrorState(error.toString()));
    });
  }

  File? imageInChat;
  var picker = ImagePicker();

  Future getImageInChat() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageInChat = File(pickedFile.path);
      emit(ChatSendImageInChatSuccessState());
    } else {
      print("no image selected");
      emit(ChatSendImageInChatErrorState());
    }
  }

  String? imageInChatString;

  void uploadImageInChat() async {
    imageInChatString = '';
    emit(ChatUploadImageInChatLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chats/${Uri.file(imageInChat!.path).pathSegments.last}')
        .putFile(imageInChat!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageInChatString = value;
        // showMessages.add(MessageModel.fromJson({"image": value}));
        print(value);
        emit(ChatUploadImageInChatSuccessState());
      }).catchError((error) {
        emit(ChatUploadImageInChatSuccessState());
      });
    }).catchError((error) {
      emit(ChatUploadImageInChatErrorState());
    });
  }

  void removeImageChat() {
    imageInChat = null;
    imageInChatString = null;
    emit(ChatRemoveImageSuccessState());
  }

  File? profileImage;

  void getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ChatImagePikedSuccessState());
    } else {
      print("no image selected");
      emit(ChatImagePikedErrorState());
    }
  }

  void uploadProfileImage() {
    emit(ChatUploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: userModel!.name!,
          phone: userModel!.phone!,
          image: value,
        );
        emit(ChatUploadImageSuccessState());
        profileImage = null;
      }).catchError((error) {
        emit(ChatUploadImageErrorState());
      });
    }).catchError((error) {
      emit(ChatUploadImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    String? image,
  }) {
    emit(UserUpdateLoadingState());
    UserModel model = UserModel(
      phone: phone,
      name: name,
      email: userModel?.email,
      image: image ?? userModel?.image,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(UserUpdateSuccessState());
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }
}
