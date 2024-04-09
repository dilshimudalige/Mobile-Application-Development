import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:flutter/material.dart';

class placeCard extends StatelessWidget {
  final String number;
  final String status;
  final String url;

  const placeCard({
    Key? key,
    required this.number,
    required this.status,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.0, // Increased height to accommodate the top black container
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover, // Adjust as per your needs
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 30.0,
              color: AppColors.transparentblackcol,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number,
                    style: TextStyle(
                      fontSize: AppFonts.paratextsize, // font size
                      // font weight
                      fontStyle: FontStyle.italic, // font style
                      fontFamily: AppFonts.btcardhintfont,
                      color: AppColors.buttontextcolor, // font family
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
