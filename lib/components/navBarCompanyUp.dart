import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/screens/activities.dart';
import 'package:coastal_heaven/screens/hotels.dart';
import 'package:coastal_heaven/screens/information.dart';
import 'package:flutter/material.dart';

class navBarCompanyUp extends StatefulWidget {
  final Color c1;
  final Color c2;
  final Color c3;
  final Color c4;
  final Color c5;
  final Color c6;
  final Color c7;
  final Color c8;

  const navBarCompanyUp({
    Key? key,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
    required this.c7,
    required this.c8,
  }) : super(key: key);

  @override
  State<navBarCompanyUp> createState() => _navBarCompanyUpState();
}

class _navBarCompanyUpState extends State<navBarCompanyUp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => Activities(),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 0.0), // Start slide from right
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.c5,
                border: Border.all(color: widget.c5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              height: 30,
              width: MediaQuery.of(context).size.width / 4.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Activities",
                    style: TextStyle(
                      fontSize: AppFonts.navtextsize,
                      fontFamily: AppFonts.navfont,
                      fontWeight: FontWeight.bold,
                      color: widget.c1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => information(),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 0.0), // Start slide from right
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.c6,
                border: Border.all(
                  color: widget.c6,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              height: 30,
              width: MediaQuery.of(context).size.width / 4.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Information",
                    style: TextStyle(
                      fontSize: AppFonts.navtextsize,
                      fontFamily: AppFonts.navfont,
                      fontWeight: FontWeight.bold,
                      color: widget.c2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const hotels(),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 0.0), // Start slide from right
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.c7,
                border: Border.all(color: widget.c7),
                borderRadius: BorderRadius.circular(6.0),
              ),
              height: 30,
              width: MediaQuery.of(context).size.width / 4.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hotels",
                    style: TextStyle(
                      fontSize: AppFonts.navtextsize,
                      fontFamily: AppFonts.navfont,
                      fontWeight: FontWeight.bold,
                      color: widget.c3,
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
