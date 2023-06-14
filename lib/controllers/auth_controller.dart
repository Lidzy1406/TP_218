import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:tiktok_debut/view/screens/auth/signup_screen.dart';

import '../model/user.dart';
import '../pages/bar.dart';
import '../screens/welcome_screen.dart';


class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? proimg;
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  void pickImage() async {
    print("IMAGE PICKED SUCCESSFULLY");
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
 //if(image == null) return;

    final img = File(image!.path);
    this.proimg = img;
  }

  //User State Persistence


   late Rx<User?> users;
  User get user => users.value!;

// _user  - Nadi
  // _user.bindStream - Nadi Me Color Deko
  //ever - Aap Ho
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    users = Rx<User?>(FirebaseAuth.instance.currentUser);
    users.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(users, _setInitialView);

    //Rx - Observable Keyword - Continously Checking Variable Is Changing Or Not.
  }

  _setInitialView(User? user){
    if(user == null){
      Get.offAll(()=> WelcomeScreen());
    }else{
      Get.offAll(() => HomePages());
    }
  }


//User Register

  void SignUp(
      String username, String email, String password, File? image) async {
    try {
      print("IMAGE HERE");
      print(image.toString() == '');
      print("IMAGE HERE");
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadProPic(image);

        myUser user = myUser(
            name: username,
            email: email,
            profilePhoto: downloadUrl,
            uid: credential.user!.uid);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Occurred", e.toString());
    }
  }

  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

  void login(String email, String password) async
  {

    try{
  if(email.isNotEmpty && password.isNotEmpty){
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }else{
    Get.snackbar("Error Logging In", "Please enter all the fields");
  }


    }catch(e){
Get.snackbar("Error Logging In",e.toString());
    }
  }

Future<myUser> getUserDetails(String email) async {
    final snapshot =
        await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email).get();
       final userData = snapshot.docs.map((e) => myUser.fromSnap(e)).first;
       return userData;
  }

  Future<List<myUser>> allUser() async {
    final snapshot = await FirebaseFirestore.instance.collection("users").get();
    final userData =
        snapshot.docs.map((e) => myUser.fromSnap(e)).toList();
    return userData;
  }

  

  signOut(){
    FirebaseAuth.instance.signOut();
    Get.offAll(WelcomeScreen());
  }
}
