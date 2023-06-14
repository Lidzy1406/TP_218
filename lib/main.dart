import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todoapp/pages/Todo/ui/router.dart';
import 'package:todoapp/screens/login/login_screen.dart';
import 'package:todoapp/utils/theme.dart';

import 'controllers/auth_controller.dart';

//import 'view/screens/auth/signup_screen.dart';

void main()  async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp().then((value){
   Get.put(AuthController());

 });
  runApp( ProviderScope(
        child: MyApp(),
      ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  get backgroundColor => null;
  @override
  Widget build(BuildContext context) {
     final colorScheme = ColorScheme.fromSeed(seedColor: Colors.indigo);
    return GetMaterialApp(
      title: 'TODO APP ',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.darkTheme.copyWith(

        scaffoldBackgroundColor: backgroundColor,
        cardTheme: const CardTheme(clipBehavior: Clip.antiAlias),
        useMaterial3: true,
        colorScheme: colorScheme,
        primaryColor: colorScheme.primary,
        buttonTheme: const ButtonThemeData(
          shape: StadiumBorder(),
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ).apply(
          displayColor: colorScheme.onSurface.withOpacity(0.75),
          bodyColor: colorScheme.onSurface,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        ),

      ),
      //  theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // home: LoginScreen(),
      // initialRoute: SplashPage.route,
       onGenerateRoute: AppRouter.onNavigate,
       home: CircularProgressIndicator(),
    );
  }
}