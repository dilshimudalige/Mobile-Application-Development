import 'package:coastal_heaven/commons/appColors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final double hit;

  final Color borderColor;
  final bool obscureText;
  final Color col1;
  final bool edits; // New property to hold the color of the icon

  const MyTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.edits = true, // Added this parameter to accept the color
      this.borderColor = AppColors.buttontextcolor,
      this.col1 = AppColors.buttontextcolor,
      this.obscureText = false,
      this.hit = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hit,
      decoration: BoxDecoration(
        color: col1,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: TextFormField(
          obscureText: obscureText,
          enabled: edits,
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,

            contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0, horizontal: 16.0), // Adjust padding as needed
            isDense: true,
          ),
        ),
      ),
    );
  }
}
