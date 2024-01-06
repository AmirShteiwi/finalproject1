//packages
import 'package:diet_app/provider_model/diet_plan_provider_model.dart';
import 'package:diet_app/provider_model/food_chart_provider_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

//providers
import 'provider_model/user_provider_model.dart';
import 'package:diet_app/provider_model/home_tab_model.dart';

//screens
import 'package:diet_app/screens/account_screens/sign_in_screen.dart';
import 'package:diet_app/screens/account_screens/sign_up_screen.dart';
import 'package:diet_app/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAdBEAlI0QecdGvjyGWDwh9I7lJoA1E6kc",
      appId: "1:398739327882:android:637cdc74f5620a67575673",
      messagingSenderId: "398739327882",
      projectId: "calorie-craft-8438a",
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeTabModel()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => FoodDataProvider()),
        ChangeNotifierProvider(create: (context) => MealPlanProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Calorie Craft',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cabin',
              ),
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.green,
              selectionColor: Color.fromARGB(183, 76, 175, 79),
              selectionHandleColor: Color.fromARGB(135, 76, 175, 79),
            ),
          ),
          home: child,
          routes: {
            '/sign-in-screen': (context) => const SignInScreen(),
            '/sign-up-screen': (context) => const SignUpScreen(),
          },
        );
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: const SplashScreen(),
      ),
    );
  }
}
