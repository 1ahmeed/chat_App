part of 'login_cubit.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates {
  String error;
  LoginErrorState(this.error);
}
