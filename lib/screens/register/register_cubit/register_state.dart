part of 'register_cubit.dart';

@immutable
abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

// ignore: must_be_immutable
class RegisterErrorState extends RegisterStates {
  String error;
  RegisterErrorState(this.error);
}
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {}

class SocialCreateUserSuccessStates extends RegisterStates{
  final String uId;
  SocialCreateUserSuccessStates(this.uId);

}
class SocialCreateUserErrorStates extends RegisterStates{
  final String error;
  SocialCreateUserErrorStates(this.error);
}
