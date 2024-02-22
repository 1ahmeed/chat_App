import 'package:chat_app/layout/chat_cubit/chat_cubit.dart';
import 'package:chat_app/layout/chat_cubit/chat_state.dart';
import 'package:chat_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../component/constant.dart';
import '../component/widgets/custom_sign_out.dart';

class LayoutScreen extends StatelessWidget {
  static String id = "LayoutScreen";

  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            title: Text(ChatCubit.get(context)!
                .titles[ChatCubit.get(context)!.currentIndex]),
            actions: [
              IconButton(onPressed: (){
                GoogleSignIn googleSignIn=GoogleSignIn();
                googleSignIn.disconnect();
                Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);

              },
                  icon: const Icon(Icons.exit_to_app)),
              TextButton(
                  onPressed: () {
                    signOut(context);
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(color: Colors.grey),
                  ))
            ],

          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              ChatCubit.get(context)!.changeIndex(index);
            },
            currentIndex: ChatCubit.get(context)!.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_sharp), label: "Chats"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ],
          ),
          body: ChatCubit.get(context)!
              .screens[ChatCubit.get(context)!.currentIndex],
        );
      },
    );
  }
}
