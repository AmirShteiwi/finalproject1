// ignore_for_file: use_build_context_synchronously

import 'package:diet_app/constants/alert_dialog.dart';
import 'package:diet_app/constants/app_bar.dart';
import 'package:diet_app/provider_model/user_provider_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  TextEditingController fullNameInputController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();
  TextEditingController heightTextController = TextEditingController();
  TextEditingController genderTextController = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isRegistered = false;

  bool containsSpecialCharacters(String text) {
    RegExp specialChars = RegExp(
        r'[!@#%^&*(),.?":{}|<>]'); // Add other special characters as needed
    return specialChars.hasMatch(text);
  }

  bool containsNumbers(String text) {
    RegExp numbers = RegExp(r'\d'); // This checks for any digit (0-9)
    return numbers.hasMatch(text);
  }

  Future<void> signUpUser() async {
    if (emailTextController.text.isEmpty ||
        passwordTextController.text.isEmpty ||
        confirmPasswordTextController.text.isEmpty ||
        fullNameInputController.text.isEmpty ||
        ageTextController.text.isEmpty ||
        weightTextController.text.isEmpty ||
        heightTextController.text.isEmpty ||
        genderTextController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => MyAlertDialog(
          title: 'Incomplete details',
          content:
              'Please enter all required details. All fields are required.',
          buttonText: 'Okay',
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
      setState(() {
        isRegistered = false;
      });
    } else if (passwordTextController.text !=
        confirmPasswordTextController.text) {
      showDialog(
        context: context,
        builder: (context) => MyAlertDialog(
          title: 'Password mismatch',
          content:
              'Your passwords do not match. Please enter your password again',
          buttonText: 'Okay',
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
      setState(() {
        isRegistered = false;
      });
    } else if (!containsSpecialCharacters(passwordTextController.text) ||
        !containsNumbers(passwordTextController.text) ||
        passwordTextController.text.length < 6) {
      showDialog(
        context: context,
        builder: (context) => MyAlertDialog(
          title: 'Weak password',
          content:
              'Password must be atleast 6 characters long, must contain atleast one special character and atleast one number.',
          buttonText: 'Okay',
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
      setState(() {
        isRegistered = false;
      });
    } else {
      String state = await context.read<UserProvider>().signup(
            emailTextController.text.trim(),
            passwordTextController.text.trim(),
            fullNameInputController.text.trim(),
            int.parse(ageTextController.text.trim()),
            double.parse(weightTextController.text.trim()),
            double.parse(heightTextController.text.trim()),
            genderTextController.text.trim(),
          );

      List<String> error = state.split('_');
      String errorCode = error[0];
      String errorMessage = error[1];

      if (errorCode == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: 'Weak password',
            content: errorMessage,
            buttonText: 'Okay',
            onButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
        setState(() {
          isRegistered = false;
        });
      } else if (errorCode == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: 'Account already exists',
            content: errorMessage,
            buttonText: 'Okay',
            onButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
        setState(() {
          isRegistered = false;
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
          isRegistered = false;
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: 'User registered successfully',
            content:
                'Your account has been created. Please sign in using your email and password',
            buttonText: 'Okay',
            onButtonPressed: () {
              Navigator.of(context).popUntil(
                  (route) => route.settings.name == '/sign-in-screen');
            },
          ),
        );
        setState(() {
          isRegistered = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Sign up'),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Column(
                  children: [
                    Image.asset('assets/images/sign-up-image.png',
                        height: screenHeight * 0.2),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: 'Righteous',
                          color: Colors.green),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full name',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Cabin',
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: fullNameInputController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
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
                          height: screenHeight * 0.05,
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
                          'Gender',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Cabin',
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownSearch<String>(
                            dropdownButtonProps: const DropdownButtonProps(
                                color: Colors.green,
                                icon: Icon(Icons.expand_more)),
                            popupProps: PopupProps.menu(
                              constraints: const BoxConstraints(
                                maxHeight: 170,
                              ),
                              menuProps: MenuProps(
                                shadowColor: Colors.green,
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1.5, color: Colors.green),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            items: const [
                              'Male',
                              'Female',
                              'Rather not specify'
                            ],
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              baseStyle: TextStyle(color: Colors.black),
                              dropdownSearchDecoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            onChanged: ((value) {
                              genderTextController.text = value as String;
                            }),
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
                          'Age',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Cabin',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: ageTextController,
                            cursorColor: Colors.green,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
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
                          'Weight [kg]',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Cabin',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: weightTextController,
                            cursorColor: Colors.green,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
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
                          'Height [cm]',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Cabin',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: heightTextController,
                            cursorColor: Colors.green,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
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
                          height: screenHeight * 0.05,
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
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirm password',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Cabin',
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: confirmPasswordTextController,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: hideConfirmPassword,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(bottom: 5),
                                icon: Icon(
                                  hideConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      hideConfirmPassword =
                                          !hideConfirmPassword;
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
                      height: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isRegistered = true;
                        });
                        signUpUser();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.8,
                              screenHeight * 0.05),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.green))),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: isRegistered,
                      child: const CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
