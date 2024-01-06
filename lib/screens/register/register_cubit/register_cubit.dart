import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
     String? phone,
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


  Future signInWithGoogle() async {
    emit(RegisterWithGoogleLoadingState());
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
    userCreateInDatabase(
        name:googleUser!.displayName! ,
        email: googleUser.email,
        // phone: phone,
        uId: googleUser.id);
      emit(RegisterWithGoogleSuccessState());
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }  catch (e) {
      print(e.toString());
      emit(RegisterWithGoogleErrorState(e.toString()));
    }
  }


  Future signInWithFacebook() async {
    emit(RegisterWithFaceBookLoadingState());
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      emit(RegisterWithFaceBookSuccessState());

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    } on Exception catch (e) {
      print(e.toString());
      emit(RegisterWithFaceBookErrorState(e.toString()));

    }
  }
}
