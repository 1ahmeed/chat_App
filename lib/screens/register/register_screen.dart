import 'package:chat_app/screens/all_chats/all_chat_screen.dart';
import 'package:chat_app/screens/register/register_cubit/register_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../component/cach_helper/shared_pref.dart';
import '../../component/constant.dart';
import '../../component/widgets/show_snack_bar.dart';
import '../../component/widgets/custom_button.dart';
import '../../component/widgets/custom_text_field.dart';
import '../../layout/chat_cubit/chat_cubit.dart';
import '../../layout/layout_screen.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  String? name;

  String? phone;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        }
        else if (state is SocialCreateUserSuccessStates) {
          isLoading = false;
          CacheHelper.saveData(key: "uId", value: state.uId);
            uId=state.uId;
            //ChatCubit.get(context)?.getUsers();
           ChatCubit.get(context)?.getUserData();
            Navigator.pushNamed(context, LayoutScreen.id,arguments: state.uId);


          showSnackBar(
            context,
            'Register Successfully',
          );
        }
        else if (state is RegisterErrorState) {
          isLoading = false;
          showSnackBar(context, state.error);
        }
        else if(state is RegisterWithGoogleSuccessState){
          Navigator.pushNamed(context, LayoutScreen.id);

        }
        },
      builder: (context, state) {
        return ModalProgressHUD(
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
                        const Image(image: AssetImage(kLogo)),
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
                        const Row(
                          children: [
                            Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          onChanged: (value) {
                            name = value;
                          },
                          hintText: 'Your name',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          label: const Text('Name'),
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
                            phone = value;
                          },
                          hintText: 'Your number',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          label: const Text('Phone'),
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
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context)?.registerUser(
                                  name: name!,
                                  email: email!,
                                  phone: phone!,
                                  password: password!
                              );
                            }
                          },
                          textButton: 'Register',
                          colorOfContainer: Colors.white,
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        CustomButton(
                          onTap: () {
                          RegisterCubit.get(context)!.signInWithGoogle();

                          },
                          textButton: 'Register with GooGle',
                          colorOfContainer: Colors.white,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          onTap: () {
                            RegisterCubit.get(context)!.signInWithFacebook();

                          },
                          textButton: 'Register with facebook',
                          colorOfContainer: Colors.white,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'have already an account ?',
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                ' Login',
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
        );
      },
    );
  }
}
