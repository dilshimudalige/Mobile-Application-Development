import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:flutter/material.dart';

class rowCard extends StatelessWidget {
  final String text1;
  final String text2;

  final Color cardColor; // New parameter for the card color
  final IconData customIcon1;
  final IconData customIcon2;
  final Color iconColor;
  final bool flag;
  final String text3;
  final bool kflag;

  const rowCard({
    Key? key,
    required this.text1,
    required this.text2,
    required this.cardColor,
    required this.customIcon1,
    required this.customIcon2,
    this.iconColor = AppColors.pureblack,
    this.flag = false,
    this.text3 = '',
    this.kflag = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(0.0),
        height: 40.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        customIcon1,
                        size: 22,
                        color: iconColor,
                      ),
                      SizedBox(width: 8), // Add spacing between icon and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text1,
                            style: TextStyle(
                              color: AppColors.pureblack,
                              fontSize: AppFonts.smalltextsize,
                              fontFamily: AppFonts.titlefont,
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Text(
                              text3,
                              style: TextStyle(
                                  color: AppColors.themecolor,
                                  fontSize: AppFonts.smalltextsize,
                                  fontFamily: AppFonts.mainfont,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
