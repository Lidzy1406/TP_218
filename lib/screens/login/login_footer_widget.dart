import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../signup/signup_screen.dart';

final signupScreenProvider = Provider<SignUpScreen>((ref) => SignUpScreen());

class LoginFooterWidget extends ConsumerWidget {
  const LoginFooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupScreen = ref.watch(signupScreenProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: tFormHeight - 20,
        ),
        TextButton(
          onPressed: () => Get.to(() => signupScreen),
          child: Text.rich(
            TextSpan(
              text: tDontHaveAnAccount,
              style: Theme.of(context).textTheme.bodyLarge,
              children: const [
                TextSpan(
                  text: tSignup,
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
