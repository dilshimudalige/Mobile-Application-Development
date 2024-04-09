import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RequestCardCp extends StatelessWidget {
  final String text;
  final String text1;
  final String text4;
  final String text5;
  final String text2;
  final String url;
  final String keys;
  final Color cardColor;
  final Color iconcolor;
  final IconData customIcon;
  final VoidCallback? onAcceptTap;
  final VoidCallback? onDeclineTap;
  final bool flag;
  final bool flags;
  final bool k1;
  final double count;
  final String text3;

  const RequestCardCp({
    Key? key,
    required this.text,
    required this.cardColor,
    required this.text1,
    required this.text2,
    required this.url,
    required this.keys,
    required this.customIcon,
    required this.iconcolor,
    this.onAcceptTap,
    this.onDeclineTap,
    this.flag = true,
    this.flags = false,
    this.k1 = false,
    this.text3 = "",
    required this.text4,
    required this.text5,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      child: Container(
        padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
        //height: 130.0,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
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
                      Visibility(
                        visible: flag,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 55, // Adjust the width of the circle
                              height: 55, // Adjust the height of the circle
                              decoration: BoxDecoration(
                                color: AppColors.chatbackcolor,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/user.png'),
                                  fit: BoxFit.cover, // Adjust as needed
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.0), // Added SizedBox to provide space
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap:
                                    () {}, // Prevents tap events from propagating
                                child: RatingBar.builder(
                                  initialRating: count,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemSize: 25.0,
                                  onRatingUpdate: (rating) {
                                    // This won't be triggered since the GestureDetector captures taps
                                    print(rating);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                text1,
                                style: TextStyle(
                                  color: AppColors.buttontextcolor,
                                  fontSize: AppFonts.largetextsize,
                                  fontFamily: AppFonts.titlefont,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true, // Allow text to wrap
                                maxLines: 2, // Set max lines to 2
                                overflow: TextOverflow
                                    .ellipsis, // Handle overflow with ellipsis
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  text4,
                                  style: TextStyle(
                                    color: AppColors.buttontextcolor,
                                    fontSize: AppFonts.vsmallfontsize,
                                    fontFamily: AppFonts.titlefont,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
