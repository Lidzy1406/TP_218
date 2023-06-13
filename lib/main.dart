import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todoapp/pages/bar.dart';
import 'package:todoapp/pages/categories/addcategories.dart';
import 'package:todoapp/pages/categories/formpage.dart';
import 'authentication/authentication_view.dart';
import 'authentication/controller/authentication_controller.dart';
import 'pages/categories/addcategories.dart';
import 'profile/profile.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

/*
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(addCategorieProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text(value),
        ),
      ),
    );
  }
}*/
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
    child: MaterialApp(
      title: 'FirebaseFirestore Demo Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Consumer(builder: (context, watch,_) {
             
                    var ref;
                    final viewModel = ref.watch(addCategorieProvider);
                    return viewModel.buildInputForm();
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
*/

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authProvider);

    Widget getHome() {
      if (authenticationState.status == AuthenticationStatus.authenticated) {
        return const HomePage();
      } else if (authenticationState.status ==
          AuthenticationStatus.unauthenticated) {
        return const AuthenticationView();
      } else {
        return const AuthenticationView();
      }
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}



// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Spin Circle Bottom Bar',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,$*

//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

