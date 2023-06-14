import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:tiktok_clone/login/authentication/authentication.dart';


import '../model/user.dart';
import 'auth_controller.dart';
import 'profile_controller.dart';

class UpdateProfController extends GetxController {
  static UpdateProfController get instance => Get.find();

  final _authRepo = Get.put(ProfileController());
  final _userRepo = Get.put(AuthController());


  getUserData() {
    final email = _userRepo.users.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  Future<List<myUser>> getAllUser() async => await _userRepo.allUser();

  updateRecord(myUser user) async {
    print("Updating record: $user");
    try {
      await _authRepo.updateUserRecord(user);

      Get.snackbar("Success", "Your record has been updated");
    } catch (e) {
      Get.snackbar("Error", "Failed to update record: $e");
      print("error, $e");
    }
  }
}
