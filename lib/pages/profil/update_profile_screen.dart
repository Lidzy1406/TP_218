import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/updateProf_controller.dart';
import '../../model/user.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controllers) {
          final ProfileController profileController =
              Get.put(ProfileController());
          final controller = Get.put(UpdateProfController());
          final AuthController authController = Get.put(AuthController());
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(LineAwesomeIcons.angle_left)),
              title: Text(
                tEditProfile,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: FutureBuilder(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        myUser users = snapshot.data as myUser;

                        final name = TextEditingController(text: users.name);
                        final email = TextEditingController(text: users.email);

                        return Column(
                          children: [
                            InkWell(
                               onTap: () {
                                  AuthController.instance.pickImage();
                             },
                           child: Stack(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: controllers.user['profilePic'],
                                    fit: BoxFit.contain,
                                    height: 100,
                                    width: 100,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: tPrimaryColor,
                                    ),
                                    child: const Icon(
                                      LineAwesomeIcons.camera,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: name,
                                    decoration: const InputDecoration(
                                      label: Text(tName),
                                      prefixIcon:
                                          Icon(Icons.person_outline_rounded),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: tFormHeight - 20,
                                  ),
                                  const SizedBox(
                                    height: tFormHeight - 20,
                                  ),
                                  TextFormField(
                                    controller: email,
                                    decoration: const InputDecoration(
                                      label: Text(tEmail),
                                      prefixIcon: Icon(Icons.email_outlined),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: tFormHeight - 20,
                                  ),
                                  const SizedBox(
                                    height: tFormHeight,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          final userData = myUser(
                                            name: name.text.trim() ??
                                                '', // Use an empty string as a fallback if name.text is null
                                            email: email.text.trim() ??
                                                '', // Use an empty string as a fallback if email.text is null
                                            profilePhoto: controllers
                                                    .user['profilePic'] ??
                                                '', // Use an empty string as a fallback if profilePic is null
                                            uid: FirebaseAuth.instance.currentUser!.uid ?? '',
                                            // surname: surname.text.trim(),
                                          );

                                          await controller
                                              .updateRecord(userData);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: tPrimaryColor,
                                            side: BorderSide.none,
                                            shape: const StadiumBorder()),
                                        child: const Text(
                                          tEditProfile,
                                          style: TextStyle(color: tDarkColor),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: tFormHeight,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text.rich(TextSpan(
                                          text: tJoined,
                                          style: TextStyle(fontSize: 12),
                                          children: [
                                            TextSpan(
                                                text: tJoinedAt,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12)),
                                          ])),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        });
  }
}
