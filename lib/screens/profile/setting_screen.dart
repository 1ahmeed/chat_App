import 'package:chat_app/component/widgets/show_toast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../component/constant.dart';
import '../../component/widgets/custom_button.dart';
import '../../component/widgets/custom_sign_out.dart';
import '../../layout/chat_cubit/chat_cubit.dart';
import '../../layout/chat_cubit/chat_state.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {
        if (state is UserUpdateSuccessState) {
          showToast(text: "Update Successfully", state: ToastStates.success);
        }
      },
      builder: (context, state) {
        var model = ChatCubit.get(context)?.userModel;
        var profileImage = ChatCubit.get(context)!.profileImage;
        if (model != null) {
          nameController.text = model.name!;
          emailController.text = model.email!;
          phoneController.text = model.phone??"";
        }

        return ConditionalBuilder(
          condition: ChatCubit.get(context)?.userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 72,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: profileImage != null
                                ? FileImage(profileImage) as ImageProvider
                                : NetworkImage(
                                    '${model!.image}',
                                  ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                ChatCubit.get(context)?.getImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (ChatCubit.get(context)!.profileImage != null)
                      Column(
                        children: [
                          if (state is ChatUploadImageLoadingState)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomButton(
                              textButton: "Upload Image",
                              colorOfContainer: kPrimaryColor,
                              colorOfText: Colors.white,
                              onTap: () {
                                ChatCubit.get(context)?.uploadProfileImage();
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' This field is required';
                        }
                        return null;
                      },
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        helperStyle: const TextStyle(color: kPrimaryColor),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        label: const Text('Name'),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: kPrimaryColor),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' This field is required';
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        helperStyle: const TextStyle(color: kPrimaryColor),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        label: const Text('email'),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: kPrimaryColor),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' This field is required';
                        }
                        return null;
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        helperStyle: const TextStyle(color: kPrimaryColor),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        label: const Text('email'),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: kPrimaryColor),
                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      color: kPrimaryColor,
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ChatCubit.get(context)?.updateUser(
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: const Text(
                          'Update User Data',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
