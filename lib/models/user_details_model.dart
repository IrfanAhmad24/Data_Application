import 'package:flutter/material.dart';

class UserDetailsModel extends ChangeNotifier {
  List<Map<String, String>> userDetailList = [];

  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String userNote = '';

  void addUserDetails({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String userNote,
  }) {
    Map<String, String> userDetails = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userNote': userNote,
    };

    userDetailList.add(userDetails);
    notifyListeners(); // Notify listeners to update UI
  }

  void removeUserDetail(int index) {
    if (index >= 0 && index < userDetailList.length) {
      userDetailList.removeAt(index);
      notifyListeners();
    }
  }

  void setUserDetails({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String userNote,
  }) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.userNote = userNote;
    notifyListeners();
  }
}
