
import 'package:chat_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit? get(context) => BlocProvider.of(context);


  bool isLoading = false;
  UserModel? userModel;

  Future<void> loginUser({
  required String email,
    required String password,
}) async {
    emit(LoginLoadingState());
    try {
      UserCredential user =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
     print(user.user!.uid);
      //print(userModel!.uId);
      emit(LoginSuccessState(user.user!.uid));
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       emit(LoginErrorState('user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState('wrong password'));
      }
    }on Exception catch (e) {
      emit(LoginErrorState('something went wrong'));
    }
  }



}
