import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class chatbox extends StatelessWidget {
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
  final VoidCallback? onTap;
  final bool flag;
  final bool flags;
  final bool k1;
  final String text3;

  const chatbox({
    Key? key,
    required this.text,
    required this.cardColor,
    required this.text1,
    required this.text2,
    required this.url,
    required this.keys,
    required this.customIcon,
    required this.iconcolor,
    this.onTap,
    this.onAcceptTap,
    this.onDeclineTap,
    this.flag = true,
    this.flags = false,
    this.k1 = false,
    this.text3 = "",
    required this.text4,
    required this.text5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    double star = 0;

    CollectionReference feedbackDB =
        FirebaseFirestore.instance.collection("feedback");

    void addUser() {
      feedbackDB.add({
        'comment': _controller.text,
        'rating': star,
        'user': "Kavinda",
      });
      _controller.clear();
    }

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
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: star,
                    minRating: 0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 30.0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      star = rating;
                      print(star);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Add your comment.",
                    style: TextStyle(
                      color: AppColors.buttontextcolor,
                      fontSize: AppFonts.paratextsize,
                      fontFamily: AppFonts.titlefont,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: MyTextField(
                      controller: _controller,
                      hintText: 'Type something.....',
                      hit: 45.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_controller.text.isNotEmpty) {
                        addUser();
                      } else {
                        print("object");
                      }
                    },
                    child: Icon(
                      Icons.send, // Built-in Material Icon
                      size: 45,
                      color: AppColors.buttontextcolor,
                    ),
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
