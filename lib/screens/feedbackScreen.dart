import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/bottomBar.dart';
import 'package:coastal_heaven/components/chatbox.dart';
import 'package:coastal_heaven/components/customTextField.dart';
import 'package:coastal_heaven/components/requestCard%20copy.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/myBookings.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController _controller = TextEditingController();
  bool clicked = false;
  double star = 0.0;

  CollectionReference feedbackDB =
      FirebaseFirestore.instance.collection("feedback");
  final userem = FirebaseAuth.instance.currentUser!;
  //String name = "";

  void addUser(String name) {
    feedbackDB.add({
      'comment': _controller.text,
      'rating': star,
      'user': name,
    });
    setState(() {
      _controller.clear();
      star = 0.0;
    });
  }

  String extractNameFromEmail(String email) {
    // Split the email address at the "@" symbol
    List<String> parts = email.split('@');

    // Take the substring before "@" as the name
    String name = parts[0];

    // Remove non-alphabetic characters using regular expressions
    name = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');

    // Return the cleaned name
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        // You can navigate to the previous screen or perform any other action
        NavigationUtils.backNavigation(context,
            BottomBar()); // This will navigate back to the previous screen
        return false; // Return false to prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: GestureDetector(
              onTap: () {
                NavigationUtils.frontNavigation(context, myBookings());
              },
              child: Icon(
                Icons.account_circle,
                size: 30,
                color: AppColors.buttontextcolor,
              ),
            ),
          ),
          title: Text(
            "Feedback",
            style: TextStyle(
              color: AppColors.buttontextcolor,
              fontSize: AppFonts.popupTitfontsize,
              fontFamily: AppFonts.titlefont,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // Sign out successful, navigate to the login page
                  NavigationUtils.backNavigation(
                      context, Splash()); // Navigate to the login page
                } catch (e) {
                  // Handle sign-out errors
                  print("Sign out error: $e");
                  SnackbarUtils.showDefaultSnackBar(
                      context,
                      "Something went wrong & please recheck",
                      AppColors.errorcolor);
                  // Show error message if needed
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Icon(
                  Icons.logout_outlined,
                  size: 30,
                  color: AppColors.buttontextcolor,
                ),
              ),
            ),
          ],
          backgroundColor: AppColors.appbarcolor,
        ),
        body: Container(
          color: AppColors.backcolor,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: feedbackDB.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var user = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 18.0, right: 38),
                              child: RequestCardCp(
                                text: '',
                                cardColor: AppColors.chatbackcolor,
                                text1: user['user'],
                                text2: "company['companyName']",
                                text3: "abbb",
                                url: "company['companyLogo']",
                                customIcon: Icons.arrow_forward,
                                keys: '',
                                iconcolor: AppColors.themecolor,
                                onAcceptTap: () {},
                                onDeclineTap: () {},
                                text4: user['comment'],
                                text5: "company['employmentType']",
                                count: user['rating'].toDouble(),
                              ),
                            );
                          });
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    //height: 130.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: AppColors.chatbackcolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 28.0, right: 28.0),
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
                                  setState(() {
                                    star = rating;
                                  });
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
                          padding:
                              const EdgeInsets.only(left: 28.0, right: 28.0),
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
                          padding:
                              const EdgeInsets.only(left: 28.0, right: 28.0),
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
                                  print(userem);
                                  if (_controller.text.isNotEmpty ||
                                      star != 0) {
                                    addUser(
                                        extractNameFromEmail(userem.email!));

                                    //print(name);
                                  } else {
                                    SnackbarUtils.showDefaultSnackBar(
                                        context,
                                        "Feedback is empty, please add & try",
                                        AppColors.errorcolor);
                                    print("object");
                                    print(extractNameFromEmail(userem.email!));
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
