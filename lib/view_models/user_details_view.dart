import 'package:flutter_practice_application/app/app.locator.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:flutter_practice_application/services/user_db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final DbService = locator<UserDBService>();

  createUserOnDB(UserModel user) async {
    await DbService.createUser(user).then((value) {
      navigationService.back();
      rebuildUi();
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  updateUserOnDb(UserModel user) async {
    await DbService.updateUser(user).then((value) => {
          navigationService.back(),
          rebuildUi(),
        });
  }

  deleteUserOnDb(UserModel user) async {
    await DbService.deleteUser(user);
    navigationService.back();
    rebuildUi();
  }
}
