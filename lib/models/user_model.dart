import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stacked/stacked.dart';
part '../user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseViewModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? userNote;
  DateTime? dateOfBirth;
  String? gender;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.userNote,
    this.dateOfBirth,
    this.gender,
    this.id,
  });

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    UserModel user = UserModel.fromJson(snapshot.data() ?? {});
    user.id = snapshot.id;
    return user;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
