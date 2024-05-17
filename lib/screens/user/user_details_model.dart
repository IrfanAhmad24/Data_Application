import 'package:flutter/material.dart';
import 'package:flutter_practice_application/app/app.locator.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:flutter_practice_application/services/user_db_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserViewModel extends BaseViewModel {
  final user = UserModel();
  final navigationService = locator<NavigationService>();
  final DbService = locator<UserDBService>();
  UserModel currentUser;
  TextEditingController? dateController;
  UserViewModel({
    required this.currentUser,
  }) {
    dateController = TextEditingController(
        text: currentUser.dateOfBirth != null
            ? DateFormat('yyyy-MM-dd').format(currentUser.dateOfBirth!)
            : '');
  }

  void datePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData.dark(),
        child: child ?? Container(),
      ),
    );
    if (pickedDate != null) {
      dateController!.text = DateFormat('yyy-MM-dd').format(pickedDate);
      currentUser.dateOfBirth = pickedDate;
      rebuildUi();
    }
  }

  createUserOnDB() async {
    await DbService.createUser(currentUser).then((value) {
      navigationService.back();
      rebuildUi();
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  updateUserOnDb() async {
    await DbService.updateUser(currentUser).then((value) => {
          navigationService.back(),
          rebuildUi(),
        });
  }

  deleteUserOnDb() async {
    await DbService.deleteUser(currentUser);
    navigationService.back();
    rebuildUi();
  }
}
