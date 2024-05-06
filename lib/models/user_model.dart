
import 'package:cloud_firestore/cloud_firestore.dart';
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
        this.id
      });


}
