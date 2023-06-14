import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/sizes.dart';
import 'package:todoapp/constants/text_strings.dart';
import 'package:todoapp/screens/signup/signup_screen.dart';
import '../constants/image_strings.dart';
import 'login/login_screen.dart';

final loginScreenProvider = Provider<LoginScreen>((ref) => LoginScreen());
final signUpScreenProvider = Provider<SignUpScreen>((ref) => SignUpScreen());

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginScreen = ref.watch(loginScreenProvider);
    final signUpScreen = ref.watch(signUpScreenProvider);

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: tPrimaryColor,
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage(tWelcomeScreenImage), height: height * 0.6,),
            Column(
              children: [
                Text(tWelcomeTitle, style: Theme.of(context).textTheme.displayMedium,),
                Text(tWelcomeSubTitle, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => loginScreen),
                    child: Text(tLogin.toUpperCase()))),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => signUpScreen), 
                    child: Text(tSignup.toUpperCase()))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
