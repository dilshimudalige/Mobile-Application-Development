import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/chatbox.dart';
import 'package:coastal_heaven/components/customTextField.dart';
import 'package:coastal_heaven/components/navBarCompanyUp.dart';
import 'package:coastal_heaven/components/placeCard.dart';
import 'package:coastal_heaven/components/rectCard.dart';
import 'package:coastal_heaven/components/requestCard%20copy.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/activities.dart';
import 'package:coastal_heaven/screens/dashboard.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:coastal_heaven/services/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class districtTourAreas extends StatefulWidget {
  const districtTourAreas({super.key});

  @override
  State<districtTourAreas> createState() => _districtTourAreasState();
}

class _districtTourAreasState extends State<districtTourAreas> {
  CollectionReference placeDB =
      FirebaseFirestore.instance.collection("tourplace");
  final userem = FirebaseAuth.instance.currentUser!;
  Color active = AppColors.themecolor;
  Color nonactive = AppColors.themecolor;

  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        // You can navigate to the previous screen or perform any other action
        NavigationUtils.backNavigation(context,
            Dashboard()); // This will navigate back to the previous screen
        return false; // Return false to prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: GestureDetector(
              onTap: () {
                NavigationUtils.backNavigation(context, Dashboard());
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 27,
                color: AppColors.buttontextcolor,
              ),
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
          width: double.infinity,
          color: AppColors.backcolor,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                Text(
                  myModel.district + " District",
                  style: TextStyle(
                    color: AppColors.pureblack, // Text color
                    fontSize: AppFonts.pofilefontsize, // Font size
                    height: 1.2,
                    fontStyle: FontStyle.italic, // Font weight
                    fontFamily: AppFonts.btcardhintfont,
                    //fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: placeDB
                        .where('city', isEqualTo: myModel.district)
                        .snapshots(),
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
                                bottom: 18.0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  final myModel = Provider.of<MyModel>(context,
                                      listen: false);
                                  myModel
                                      .updatedescription(user['description']);
                                  myModel.updateplace(user['place']);
                                  print(myModel.placeName);
                                  print("object***");
                                  NavigationUtils.frontNavigation(
                                      context, Activities());
                                },
                                child: placeCard(
                                  number: user['place'],
                                  status: '',
                                  url: user['photo'],
                                ),
                              ),
                            );
                          });
                    },
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
