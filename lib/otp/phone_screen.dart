import 'package:flutter/material.dart';

import 'otp_screen.dart';

class Phone extends StatefulWidget {
  static const String routeName = "Phone";

  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController phoneController = TextEditingController();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Number"),
        centerTitle: true,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.popAndPushNamed(context, UserAuth.routeName);
        //     },
        //     icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Form(
            key: form,
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                const String phonePattern = r'^(?:[+0][1-9])?[0-9]{11}$';
                final regExp = RegExp(phonePattern);
                if (value == null || value.isEmpty) {
                  return "Enter your phone number";
                } else if (!regExp.hasMatch(value)) {
                  return "Enter a correct number";
                }

                return null;
              },
                // contextMenuBuilder:(context, editableTextState) {
                // },
              toolbarOptions: const ToolbarOptions(
                  copy: true,
                  cut: true,
                  paste: true,
                  selectAll: true
              ),
              maxLength: 13,
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: "+20 000 000 000",
                  constraints: BoxConstraints(maxWidth: 350),
                  label: Text(
                    "Enter your Phone number ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                 floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  border: OutlineInputBorder()),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (form.currentState!.validate()) {
                // Navigator.pushReplacementNamed(context, OTP.routeName,
                //     arguments: phoneController.text);
              }
            },
            child: const Text("Send Code"))
      ]),
    );
  }

  @override
  void dispose() {
    // ignore: avoid_print
    print("dispose  phone c");
    phoneController.dispose();
    super.dispose();
  }
}