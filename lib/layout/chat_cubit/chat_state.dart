// part of 'chat_cubit.dart';
//
// @immutable

abstract class ChatStates {}

class ChatInitial extends ChatStates {}



class ChatBottomNavBarState extends ChatStates{}

class ChatGetUserDataLoadingState extends ChatStates{}
class ChatGetUserDataSuccessState extends ChatStates{}
class ChatGetUserDataErrorState extends ChatStates{
  final error;
  ChatGetUserDataErrorState(this.error);
}

class ChatGetAllUserLoadingState extends ChatStates{}
class ChatGetAllUserSuccessState extends ChatStates{}
class ChatGetAllUserErrorState extends ChatStates{
  final  error;
  ChatGetAllUserErrorState(this.error);
}

class ChatGetMessagesSuccessState extends ChatStates{}
class ChatGetMessagesErrorState extends ChatStates{}
class ChatSendMessageSuccessState extends ChatStates{}
class ChatSendMessageErrorState extends ChatStates{}

class ChatImagePikedSuccessState extends ChatStates{}
class ChatImagePikedErrorState extends ChatStates{}

class ChatSendImageInChatSuccessState extends ChatStates{}
class ChatSendImageInChatErrorState extends ChatStates{}

class ChatUploadImageInChatLoadingState extends ChatStates{}
class ChatUploadImageInChatSuccessState extends ChatStates{}
class ChatUploadImageInChatErrorState extends ChatStates{}

class ChatRemoveImageSuccessState extends ChatStates{}

class ChatUploadImageLoadingState extends ChatStates{}
class ChatUploadImageSuccessState extends ChatStates{}
class ChatUploadImageErrorState extends ChatStates{}


class UserUpdateLoadingState extends ChatStates{}
class UserUpdateSuccessState extends ChatStates{}
class UserUpdateErrorState extends ChatStates{}


