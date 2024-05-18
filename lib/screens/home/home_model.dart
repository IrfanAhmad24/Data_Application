import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_application/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../models/user_model.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  List<UserModel> userDetailList = [];
  getSteam() {
    final ref = FirebaseFirestore.instance.collection('users').snapshots();
    return ref;
  }

  Future<void> navigateToUserDetails({UserModel? user}) async {}
}
