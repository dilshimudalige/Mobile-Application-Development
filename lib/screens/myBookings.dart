import 'package:coastal_heaven/components/bottomBar.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coastal_heaven/components/rowCard%20copy.dart';
import 'package:coastal_heaven/services/provider.dart';
import 'package:provider/provider.dart';
import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/snackBar.dart';

class myBookings extends StatefulWidget {
  const myBookings({Key? key});

  @override
  State<myBookings> createState() => _myBookingsState();
}

class _myBookingsState extends State<myBookings> {
  CollectionReference placeDB =
      FirebaseFirestore.instance.collection("bookings");
  late User userem;
  Color active = AppColors.pureblack;
  Color nonactive = AppColors.buttontextcolor;

  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen: false);
    userem = FirebaseAuth.instance.currentUser!;
    return WillPopScope(
      onWillPop: () async {
        NavigationUtils.backNavigation(context, BottomBar());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: GestureDetector(
              onTap: () {
                NavigationUtils.backNavigation(context, BottomBar());
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 27,
                color: AppColors.buttontextcolor,
              ),
            ),
          ),
          title: Text(
            userem.displayName ?? "",
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
                  NavigationUtils.backNavigation(context, Splash());
                } catch (e) {
                  SnackbarUtils.showDefaultSnackBar(
                      context,
                      "Something went wrong & please recheck",
                      AppColors.errorcolor);
                  print("Sign out error: $e");
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backcolor,
                ),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "All Bookings",
                      style: TextStyle(
                        color: AppColors.pureblack,
                        fontSize: AppFonts.pofilefontsize,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.btcardfont,
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: placeDB
                            .where('user', isEqualTo: userem.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var user = snapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8.0,
                                  ),
                                  child: Dismissible(
                                    key: Key(user.id),
                                    confirmDismiss: (direction) async {
                                      return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Confirmation"),
                                            content: Text(
                                                "Do you want to cancel the booking?"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false), // No
                                                child: Text(
                                                  "No",
                                                  style: TextStyle(
                                                    color: AppColors.themecolor,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true), // Yes
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                    color: AppColors.themecolor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    onDismissed: (direction) async {
                                      await placeDB
                                          .doc(user.id)
                                          .delete()
                                          .then((value) {
                                        SnackbarUtils.showDefaultSnackBar(
                                            context,
                                            "Booking deleted successfully",
                                            AppColors.successcolor);
                                      }).catchError((error) {
                                        SnackbarUtils.showDefaultSnackBar(
                                            context,
                                            "Failed to delete booking",
                                            AppColors.errorcolor);
                                      });
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 20.0),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, right: 18.0),
                                        child: rowCardCp(
                                          text1: user['hotel'],
                                          text2: user['type'],
                                          text3: user['count'],
                                          text4: user['date'],
                                          cardColor: AppColors.botbarcolor,
                                          customIcon1: Icons.book_outlined,
                                          customIcon2: Icons.arrow_forward_ios,
                                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
