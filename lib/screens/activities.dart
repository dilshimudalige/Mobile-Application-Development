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
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/districtTourAreas.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:coastal_heaven/services/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
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
                  NavigationUtils.backNavigation(context, Splash());
                  // Navigate to the login page
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
                c1: active,
                c2: nonactive,
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
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/activities.png'), // Replace 'background_image.jpg' with your actual image asset path
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1. Snorkeling ",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.paratextsize, // Font size
                            height: 1.2,
                            fontWeight: FontWeight.bold,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "One of the top things to do in Hikkaduwa Beach is snorkeling. The reason is that one of just two marine parks in Sri Lanka is located off Hikkaduwa. Simply rent some snorkeling gear and take a short boat ride over to the Hikkaduwa Coral Reef. Once you arrive, dive in and enjoy the views of the underwater world. There are many local tour operators that can organize snorkelling trips and the average cost is around 2,000 rupees for one hour. The best time of year for snorkelling is between November and April.",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.smalltextsize, // Font size
                            height: 1.5,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "2. Glass Bottom Boat Ride",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.paratextsize, // Font size
                            height: 1.2,
                            fontWeight: FontWeight.bold,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "If snorkeling is not your thing or your kids are too young, then a ride on a glass-bottom boat is the perfect (and a unique) way to explore the sea life from above. The transparent bottom boats are available on the main beach to hire and explore independently.",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.smalltextsize, // Font size
                            height: 1.5,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "3. Surfing ",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.paratextsize, // Font size
                            height: 1.2,
                            fontWeight: FontWeight.bold,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Hikkaduwa area is famous for surfing among adventure enthusiasts. The clean waves and consistent swell are what attract surfers to the area to enjoy this fun outdoor activity. Surfboards are available for hire on the beach. It is a good place to learn to surf as the waves are often suited for beginners. Ask any one of the board rental guys to teach you in return for a fee.",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.smalltextsize, // Font size
                            height: 1.5,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "4. Watch Baby Turtles Be Released ",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.paratextsize, // Font size
                            height: 1.2,
                            fontWeight: FontWeight.bold,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "If snorkeling didn’t satisfy your evergreen curiosity for spotting turtles, watching them be released into the ocean is another great experience. The local turtle hatchery on Hikkaduwa Beach releases the turtles into the ocean most evenings.",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.smalltextsize, // Font size
                            height: 1.5,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "5. Diving ",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.paratextsize, // Font size
                            height: 1.2,
                            fontWeight: FontWeight.bold,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Stunning Unawatuna Beach is the most famous diving spot on the southern coast. Both locals and foreigners come to get their diving licenses from PADI diving centers in Unawatuna. It is an excellent diving site consisting of rocky formations, many shipwrecks, and numerous varieties of fish.",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.smalltextsize, // Font size
                            height: 1.5,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "6. Whale watching ",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.paratextsize, // Font size
                            height: 1.2,
                            fontWeight: FontWeight.bold,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Sri Lanka is one of the best whale watching spots in the world, the southern end of the continental shelf extends into very deep waters, and large groups of dense and graceful blue whales can be seen approaching the coast. Every April and November, a large number of whales and dolphins will follow the ocean currents from the north of the Antarctic to the Indian Ocean to breed their offspring, which is a good season for whale watching.",
                          style: TextStyle(
                            color: AppColors.pureblack, // Text color
                            fontSize: AppFonts.smalltextsize, // Font size
                            height: 1.5,

                            fontFamily: AppFonts.titlefont,
                            //fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
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
