import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import "package:shared_preferences/shared_preferences.dart";

class MyModel extends ChangeNotifier {
  String district = "";

  void updatedistrict(String newValue) {
    district = newValue;
    notifyListeners(); // Notifies listeners that the value has changed
  }

  String description = "";

  void updatedescription(String newValue) {
    description = newValue;
    notifyListeners(); // Notifies listeners that the value has changed
  }

  String placeName = "";

  void updateplace(String newValue) {
    placeName = newValue;
    notifyListeners(); // Notifies listeners that the value has changed
  }

  String hotel = "";

  void updateHotel(String newValue) {
    hotel = newValue;
    notifyListeners(); // Notifies listeners that the value has changed
  }
}
