import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:todoapp/pages/profil/update_profile_screen.dart';
import 'package:todoapp/pages/profil/user_management.dart';
import 'package:todoapp/pages/profil/widgets/Profil_menu.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';

// import '../../login/authentication/authentication.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  void initState() {
    // TODO: implement initState
    super.initState();

    profileController.updateUseId(widget.uid);
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          var isDark =
              MediaQuery.of(context).platformBrightness == Brightness.dark;
          return Scaffold(
            appBar: AppBar(
              title: Text('@${controller.user["name"]}'),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.snackbar("Switch to moon", "Put phone on dark mode");
                    },
                    icon: Icon(
                        isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: controller.user['profilePic'],
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
                              LineAwesomeIcons.alternate_pencil,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () =>
                              Get.to(() => const UpdateProfileScreen()),
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
                      height: 30,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    ProfileMenuWidget(
                      title: 'User management',
                      icon: LineAwesomeIcons.user_check,
                      onPress: () {
                        print("User Management pressed!");
                        Get.to(() => UserManagement());
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ProfileMenuWidget(
                        title: 'Sign Out',
                        icon: LineAwesomeIcons.alternate_sign_out,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          authController.signOut();
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
