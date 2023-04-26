import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key, this.hintText,this.label,this.prefixIcon,this.suffixIcon,this.onChanged,
     this.controller,}) ;
  String? hintText ;
   Widget? label;
   Widget? prefixIcon;
   Widget? suffixIcon;
   TextEditingController? controller;
   void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      validator: (value){
        if(value!.isEmpty){
          return ' This field is required';
        }
        return null;
      },

      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        helperStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        label:label,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
        prefixIcon:prefixIcon,
        suffixIcon: suffixIcon,
        //prefixIconColor: Colors.white

      ),

    );
  }
}
