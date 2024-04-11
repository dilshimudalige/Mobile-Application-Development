import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/button.dart';
import 'package:coastal_heaven/components/customTextField.dart';
import 'package:coastal_heaven/components/label.dart';
import 'package:coastal_heaven/components/navBarCompanyUp.dart';
import 'package:coastal_heaven/components/placeCard.dart';
import 'package:coastal_heaven/components/rowCard.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/districtTourAreas.dart';
import 'package:coastal_heaven/screens/hotels.dart';
import 'package:coastal_heaven/screens/myBookings.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:coastal_heaven/services/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HotelBook extends StatefulWidget {
  const HotelBook({Key? key});

  @override
  State<HotelBook> createState() => _HotelBookState();
}

class _HotelBookState extends State<HotelBook> {
  final countcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  CollectionReference bookDB =
      FirebaseFirestore.instance.collection("bookings");
  late User userem;
  Color active = AppColors.pureblack;
  Color nonactive = AppColors.buttontextcolor;
  TextEditingController _dateController = TextEditingController();

  DateTime? _selectedDate;
  var selectedValue2;
  List<String> listItem2 = [
    'AC   2 Person',
    'AC   5 Person',
    'AC   10 Person',
    'NON-AC   2 Person',
    'NON-AC   5 Person',
    'NON-AC   10 Person',
  ];
  var hint2 = "Room type";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        String formattedDate =
            DateFormat('yyyy-MM-dd').format(picked); // Format date
        _dateController.text =
            formattedDate; // Update text field with formatted date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen: false);
    userem = FirebaseAuth.instance.currentUser!;

    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        // You can navigate to the previous screen or perform any other action
        NavigationUtils.backNavigation(context,
            hotels()); // This will navigate back to the previous screen
        return false; // Return false to prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: GestureDetector(
              onTap: () {
                NavigationUtils.backNavigation(context, hotels());
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 27,
                color: AppColors.buttontextcolor,
              ),
            ),
          ),
          title: Text(
            myModel.hotel,
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Your other widgets here
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/roomBK.png'), // Replace 'background_image.jpg' with your actual image asset path
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 50.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Label(
                              hintText: "Book Your Rooms",
                              textColor: AppColors.themecolor,
                              fontSize: AppFonts.pofilefontsize,
                              fontFamily: AppFonts.titlefont,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          height: 50.0,
                          padding:
                              EdgeInsets.only(left: 16.0, right: 6.0, top: 5.0),
                          decoration: BoxDecoration(
                            color: AppColors.buttontextcolor,
                            border:
                                Border.all(color: AppColors.buttontextcolor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: DropdownButton<String>(
                            hint: Text(
                              hint2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            isExpanded: true,
                            underline: SizedBox(),
                            value: selectedValue2,
                            style: TextStyle(
                              fontSize: AppFonts.textsize,
                              fontFamily: AppFonts.mainfont,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue2 = newValue!;
                              });
                            },
                            items: listItem2.map((String valueItem) {
                              return DropdownMenuItem<String>(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        MyTextField(
                          keyboardType: TextInputType.number,
                          controller: countcontroller,
                          hintText: 'Room count',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: AppColors.buttontextcolor,
                            borderRadius: BorderRadius.circular(
                                15.0), // Set border radius here
                          ),
                          child: TextFormField(
                            controller: _dateController,
                            onTap: () {
                              _selectDate(
                                  context); // Open calendar when text field is tapped
                            },
                            readOnly: true, // Make text field read-only
                            decoration: InputDecoration(
                              hintText: 'Booking date',
                              hintStyle: TextStyle(
                                color: Colors
                                    .grey, // Change the color of the hint text
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: Colors
                                        .transparent), // Set border color to red
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .transparent), // Set border color to red
                                // Set focused border color to red
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .transparent), // Set enabled border color to red
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () {
                                  _selectDate(
                                      context); // Open calendar when icon is tapped
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        MyTextField(
                          keyboardType: TextInputType.number,
                          controller: phonecontroller,
                          hintText: 'Phone number',
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Button(
                          onPressed: () {
                            if (selectedValue2 != null &&
                                countcontroller.text.isNotEmpty &&
                                _dateController.text.isNotEmpty &&
                                phonecontroller.text.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirmation'),
                                    content: Text(
                                        'Are you sure you want to proceed the booking?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: AppColors.themecolor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Do something when the "OK" button is pressed.
                                          bookDB.add({
                                            'user': userem.email,
                                            'type': selectedValue2,
                                            'phone': phonecontroller.text,
                                            'hotel': myModel.hotel,
                                            'date': _dateController.text,
                                            'count': countcontroller.text
                                          });
                                          SnackbarUtils.showDefaultSnackBar(
                                              context,
                                              "Successfully booked",
                                              AppColors.successcolor);

                                          Navigator.of(context).pop();
                                          NavigationUtils.backNavigation(
                                              context, myBookings());
                                        },
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                            color: AppColors.themecolor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              SnackbarUtils.showDefaultSnackBar(
                                  context,
                                  "Some required fiels are missing",
                                  AppColors.errorcolor);
                            }
                          },

                          text: 'Book now',
                          buttonColor: AppColors.themecolor,
                          width: double.infinity, // Set the button width here
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
