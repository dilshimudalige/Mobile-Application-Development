import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color buttonColor;
  final double width; // New parameter for button width
  final double rad;

  const Button({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.buttonColor,
    required this.width, // Required button width
    this.rad = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: width, // Use the provided width
      //margin: EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(rad),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: AppFonts.largetextsize,
            fontFamily: AppFonts.titlefont,
            fontWeight: FontWeight.bold,
            color: AppColors.buttontextcolor,
          ),
        ),
      ),
    );
  }
}
