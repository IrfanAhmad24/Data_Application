import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? userNote;
  DateTime? dateOfBirth;
  String? gender;
  User(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.userNote,
      this.dateOfBirth,
      this.gender,
      this.id});
  Map<String, dynamic> toJson() => {
        'id': id,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'userNote': userNote,
        'dateOfBirth': dateOfBirth != null
            ? DateFormat('yyyy-MM-dd').format(dateOfBirth!)
            : null,
        'gender': gender,
        'firstName': firstName,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      userNote: json['userNote'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
    );
  }
}
