import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_practice_application/models/user_model.dart';

class UserDBService {
  final collection =
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromSnapshot(
                snapshot.data()! as DocumentSnapshot<Map<String, dynamic>>),
            toFirestore: (user, _) => user.toJson(),
          );

  Future createUser(UserModel user) async {
    try {
      String customId = DateTime.now().millisecondsSinceEpoch.toString();
      user.id = customId;
      await collection.doc(user.id).set(user);
    } catch (error) {
      print('Error creating user: $error');
      throw error;
    }
  }

  Future<void> updateUser(UserModel user) async {
    return collection.doc(user.id).update(user.toJson());
  }

  deleteUser(UserModel user) {
    return collection.doc(user.id).delete();
  }
}
