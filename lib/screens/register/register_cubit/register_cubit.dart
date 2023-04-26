import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit? get(context) => BlocProvider.of(context);



  UserModel? model;
  Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
        UserCredential user =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
        // print(user.user!.uid);
        userCreateInDatabase(
          uId:user.user!.uid,
          email: email,
          phone: phone,
          name: name,
        );
       // emit(RegisterSuccessState());
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState('weak password'));

      } else if (e.code == 'email-already-in-use') {
       emit(RegisterErrorState('email already in use'));
      }
    } on Exception catch (e) {
      emit(RegisterErrorState('something went wrong'));
    }
  }



  Future<void> userCreateInDatabase ({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) async {
    UserModel model =  UserModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXb55j9I_AwNtRqlxC-eSoNb8OvqCyPmb7Qg&usqp=CAU'
    );
    print("tokennnnnn");
    print(model.uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessStates(uId));
    }).catchError((error) {
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }
}
