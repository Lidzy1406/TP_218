import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/user.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUseId(String? uid) {
    _uid.value = uid ?? '';
    getUserData();
  }

  Future<void> updateUserRecord(myUser user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_uid.value)
        .update(user.toJson());
  }

  getUserData() async {
    if (_uid.value == '') {
      return;
    }

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("users").doc(_uid.value).get();

    if (userDoc.exists) {
      final userData = userDoc.data() as dynamic;

      String name = userData['name'] ?? '';
      String profilePic = userData['profilePic'] ?? '';
      String email = userData['email']?? '';

      // mettre à jour l'utilisateur dans le contrôleur de profil
      updateUser(myUser(uid: _uid.value, name: name,email: email, profilePhoto: profilePic));
    }
  }

  void updateUser(myUser user) {
    _user.value = user.toJson();
    update();
  }
}