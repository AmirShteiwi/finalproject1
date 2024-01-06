// ignore_for_file: use_build_context_synchronously

import 'package:diet_app/constants/alert_dialog.dart';
import 'package:diet_app/provider_model/diet_plan_provider_model.dart';
import 'package:diet_app/provider_model/food_chart_provider_model.dart';
import 'package:diet_app/provider_model/user_provider_model.dart';
import 'package:diet_app/screens/account_screens/recover_account_screen.dart';
import 'package:diet_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool hidePassword = true;
  bool isLoggedIn = false;

  Future<void> logInUser() async {
    if (emailTextController.text.isEmpty ||
        passwordTextController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => MyAlertDialog(
          title: 'Incomplete details',
          content: 'Please enter both email address and password',
          buttonText: 'Okay',
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
      setState(() {
        isLoggedIn = false;
      });
    } else {
      String state = await context
          .read<UserProvider>()
          .login(emailTextController.text, passwordTextController.text);
      List<String> error = state.split('_');
      String errorCode = error[0];
      String errorMessage = error[1];

      if (errorCode == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: 'Unknown user',
            content: errorMessage,
            buttonText: 'Okay',
            onButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
        setState(() {
          isLoggedIn = false;
        });
      } else if (errorCode == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: 'Invalid credentials',
            content: errorMessage,
            buttonText: 'Okay',
            onButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
        setState(() {
          isLoggedIn = false;
        });
      } else if (errorCode == 'invalid-credential') {
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: 'Invalid credentials',
            content: errorMessage,
            buttonText: 'Okay',
            onButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
        setState(() {
          isLoggedIn = false;
        });
      } else if (errorCode == 'invalid-email') {
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: 'Invalid email',
            content: errorMessage,
            buttonText: 'Okay',
            onButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
        setState(() {
          isLoggedIn = false;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var foodProvider = context.read<FoodDataProvider>();
    var dietPlanProvider = context.read<MealPlanProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/sign-in-image.png',
                        height: MediaQuery.of(context).size.height * 0.2),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login In',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: 'Righteous',
                          color: Colors.green),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email address',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Cabin',
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.green,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Cabin',
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: passwordTextController,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: hidePassword,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(bottom: 5),
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      hidePassword = !hidePassword;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecoverAccountScreen(),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoggedIn = true;
                        });
                        logInUser();
                        foodProvider.fetchData();
                        foodProvider.initRealtimeListener();
                        dietPlanProvider.fetchMealPlans();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                            MediaQuery.of(context).size.height * 0.05),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: isLoggedIn,
                      child: const CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont have an account? '),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/sign-up-screen'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
