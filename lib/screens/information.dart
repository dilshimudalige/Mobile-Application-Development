import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/activityCard.dart';
import 'package:coastal_heaven/components/chatbox.dart';
import 'package:coastal_heaven/components/customTextField.dart';
import 'package:coastal_heaven/components/navBarCompanyUp.dart';
import 'package:coastal_heaven/components/placeCard.dart';
import 'package:coastal_heaven/components/rectCard.dart';
import 'package:coastal_heaven/components/requestCard%20copy.dart';
import 'package:coastal_heaven/components/rowCard.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/districtTourAreas.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:coastal_heaven/services/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class information extends StatefulWidget {
  const information({Key? key});

  @override
  State<information> createState() => _informationState();
}

class _informationState extends State<information> {
  CollectionReference placeDB =
      FirebaseFirestore.instance.collection("tourplace");
  final userem = FirebaseAuth.instance.currentUser!;
  Color active = AppColors.pureblack;
  Color nonactive = AppColors.buttontextcolor;

  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        // You can navigate to the previous screen or perform any other action
        NavigationUtils.backNavigation(context,
            districtTourAreas()); // This will navigate back to the previous screen
        return false; // Return false to prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: GestureDetector(
              onTap: () {
                NavigationUtils.backNavigation(context, districtTourAreas());
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 27,
                color: AppColors.buttontextcolor,
              ),
            ),
          ),
          title: Text(
            myModel.placeName,
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
                  SnackbarUtils.showDefaultSnackBar(
                      context,
                      "Something went wrong & please recheck",
                      AppColors.errorcolor);

                  // Handle sign-out errors
                  print("Sign out error: $e");
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: AppColors.backcolor,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: navBarCompanyUp(
                c1: nonactive,
                c2: active,
                c3: nonactive,
                c4: nonactive,
                c5: AppColors.backcolor,
                c6: AppColors.backcolor,
                c7: AppColors.backcolor,
                c8: AppColors.backcolor,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/inforback.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            myModel.description,
                            style: TextStyle(
                              color: AppColors.pureblack, // Text color
                              fontSize: AppFonts.smalltextsize, // Font size
                              height: 1.5,

                              fontFamily: AppFonts.titlefont,
                              //fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
