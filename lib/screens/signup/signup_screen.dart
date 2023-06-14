import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todoapp/screens/signup/sign_up_form_widget.dart';
import '../../common_widget/form_header_widget.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../login/login_screen.dart';

final loginScreenControllerProvider = Provider<LoginScreenController>((ref) => LoginScreenController());

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize + 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignupTitle,
                  subTitle: tSignupSubTitle,
                ),
                SignUpWidget(),
                Consumer(
                  builder: (context, watch, _) {
                    final loginScreenController = ref.watch(loginScreenControllerProvider);
                    return Column(
                      children: [
                        TextButton(
                          onPressed: () => loginScreenController.goToLoginScreen(), 
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: tAlreadyHaveAnAccount, style: Theme.of(context).textTheme.bodyLarge),
                                TextSpan(text: tLogin.toUpperCase(), style: TextStyle(color: Colors.blue)),
                              ]
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreenController {
  void goToLoginScreen() {
    Get.to(() => const LoginScreen());
  }
}
