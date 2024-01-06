import 'package:chat_app/layout/layout_screen.dart';
import 'package:chat_app/screens/all_chats/all_chat_screen.dart';
import 'package:chat_app/screens/register/register_screen.dart';
import 'package:chat_app/test_notificaions/notify_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../component/cach_helper/shared_pref.dart';
import '../../component/constant.dart';
import '../../component/widgets/show_snack_bar.dart';
import '../../component/widgets/custom_button.dart';
import '../../component/widgets/custom_text_field.dart';
import '../../layout/chat_cubit/chat_cubit.dart';
import 'login_cubit/login_cubit.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';

  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          isLoading = false;
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
            uId=CacheHelper.getData(key: "uId");
            ChatCubit.get(context)?.getUserData();
             Navigator.pushNamed(context, LayoutScreen.id,arguments: state.uId);
            // Navigator.pushNamedAndRemoveUntil(context, NotifyScreen.id, (route) => false);
          //
          });
          showSnackBar(context, 'Login Successfully',);
        } else if (state is LoginErrorState) {
          isLoading = false;
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const  Image(image: AssetImage(kLogo)),
                      const Text(
                        'Scholar Chat',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Pacifico'),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Login In',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        hintText: 'name@gmail.com',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        label: const Text('Email'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        hintText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        label: const Text('Password'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context)
                                ?.loginUser(email: email!, password: password!);
                          }
                        },
                        textButton: 'Login',
                        colorOfContainer: Colors.white,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'don\'t have an account ?',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterScreen.id);
                            },
                            child: const Text(
                              ' Register',
                              style: TextStyle(color: Color(0xffC7EDE6)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
