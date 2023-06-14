import 'package:flutter/material.dart';
import '../../constants/sizes.dart';
import 'login_footer_widget.dart';
import 'login_form.dart';
import 'login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize + 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginHeaderWidget(),
                LoginForm(),
                const LoginFooterWidget(),
            ],
           ),
          ),
        ),
      ),
    );
  }
  
}
