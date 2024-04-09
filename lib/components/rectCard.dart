import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:flutter/material.dart';

class RectCard extends StatelessWidget {
  final String number;
  final String status;
  final String url;

  const RectCard({
    Key? key,
    required this.number,
    required this.status,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      //padding: const EdgeInsets.all(16.0),
      height: 200,
      width: MediaQuery.of(context).size.width / 2.5,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width / 2.38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                image: DecorationImage(
                  image: NetworkImage(url), // Use the provided URL
                  fit: BoxFit.cover, // Adjust as needed
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width / 2.38,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number + " District",
                    style: TextStyle(
                      fontFamily: AppFonts.titlefont,
                      color: AppColors.pureblack, // Text color
                      fontSize: AppFonts.Ctitlesize, // Text size
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
