import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.textButton, required this.onTap,required this.colorOfContainer,this.colorOfText});

  String textButton;
  void Function()? onTap;
  Color? colorOfContainer;
  Color? colorOfText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: colorOfContainer,
          //HexColor('333739'),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
          textButton,
          style: TextStyle(fontWeight: FontWeight.bold,color:colorOfText ),
        )),
      ),
    );
  }
}
