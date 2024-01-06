part of 'register_cubit.dart';

abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  String error;
  RegisterErrorState(this.error);
}
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {}

class RegisterWithGoogleErrorState extends RegisterStates {
  String error;
  RegisterWithGoogleErrorState(this.error);
}
class RegisterWithGoogleLoadingState extends RegisterStates {}
class RegisterWithGoogleSuccessState extends RegisterStates {}

class RegisterWithFaceBookErrorState extends RegisterStates {
  String error;
  RegisterWithFaceBookErrorState(this.error);
}
class RegisterWithFaceBookLoadingState extends RegisterStates {}
class RegisterWithFaceBookSuccessState extends RegisterStates {}

class SocialCreateUserSuccessStates extends RegisterStates{
  final String uId;
  SocialCreateUserSuccessStates(this.uId);

}
class SocialCreateUserErrorStates extends RegisterStates{
  final String error;
  SocialCreateUserErrorStates(this.error);
}
