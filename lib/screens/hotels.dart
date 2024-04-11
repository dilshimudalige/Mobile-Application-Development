import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/button.dart';
import 'package:coastal_heaven/components/navBarCompanyUp.dart';
import 'package:coastal_heaven/components/placeCard.dart';
import 'package:coastal_heaven/components/rowCard.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/districtTourAreas.dart';
import 'package:coastal_heaven/screens/hotelbook.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:coastal_heaven/services/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class hotels extends StatefulWidget {
  const hotels({Key? key});

  @override
  State<hotels> createState() => _hotelsState();
}

class _hotelsState extends State<hotels> {
  CollectionReference placeDB = FirebaseFirestore.instance.collection("hotels");
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
                c2: nonactive,
                c3: active,
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
              Stack(children: [
                Button(
                    rad: 0,
                    onPressed: () async {
                      final web = Uri.parse('https://www.booking.com/');
                      launchUrl(
                        web,
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    text: 'More bookings with        ',
                    buttonColor: AppColors.themecolor,
                    width: double.infinity // Set the button width here
                    ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.2,
                  top: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      final web = Uri.parse('https://www.booking.com/');
                      launchUrl(
                        web,
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/bcom.png'), // Your image path here
                          fit: BoxFit
                              .cover, // You can adjust the fit as per your requirement
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              // Your other widgets here
              Container(
                decoration: BoxDecoration(color: AppColors.backcolor
                    /* image: DecorationImage(
                    image: AssetImage(
                        'assets/hotelbk.png'), // Replace 'background_image.jpg' with your actual image asset path
                    fit: BoxFit.cover,
                  ),*/
                    ),
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                  stream: placeDB
                      .where('place', isEqualTo: myModel.placeName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var user = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                final myModel = Provider.of<MyModel>(context,
                                    listen: false);
                                myModel.updateHotel(user['hotel']);

                                NavigationUtils.frontNavigation(
                                    context, HotelBook());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18.0),
                                child: placeCard(
                                  number: user['hotel'],
                                  status: '',
                                  url: user['url'],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
