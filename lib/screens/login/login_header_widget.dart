import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';

final loginTitleProvider = Provider<String>((ref) => tLoginTitle);
final loginSubTitleProvider = Provider<String>((ref) => tLoginSubTitle);

class LoginHeaderWidget extends ConsumerWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final loginTitle = ref.watch(loginTitleProvider);
    final loginSubTitle = ref.watch(loginSubTitleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(tWelcomeScreenImage),
          height: size.height * 0.3,
        ),
        Text(
          loginTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          loginSubTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
