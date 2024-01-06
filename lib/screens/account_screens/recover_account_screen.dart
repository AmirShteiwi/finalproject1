// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:diet_app/constants/alert_dialog.dart';
import 'package:diet_app/constants/app_bar.dart';
import 'package:diet_app/provider_model/user_provider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RecoverAccountScreen extends StatefulWidget {
  const RecoverAccountScreen({super.key});

  @override
  State<RecoverAccountScreen> createState() => _RecoverAccountScreenState();
}

class _RecoverAccountScreenState extends State<RecoverAccountScreen> {
  TextEditingController emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;

    Future<void> recoverAccount(String email) async {
      if (emailTextController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: 'Incomplete details',
            content: 'Please enter your email address to recover your account',
            buttonText: 'Okay',
            onButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      } else {
        String state = await context.read<UserProvider>().resetPassword(email);

        List<String> error = state.split('_');
        String errorCode = error[0];
        String errorMessage = error[1];

        if (errorCode == 'invalid-email') {
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
        } else if (errorCode != "Success") {
          showDialog(
            context: context,
            builder: (context) => MyAlertDialog(
              title: 'Error recovering account',
              content: state,
              buttonText: 'Okay',
              onButtonPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => MyAlertDialog(
              title: 'Recovery email sent',
              content:
                  'A password reset link has been sent to your email. Check your spam/junk folders.',
              buttonText: 'Okay',
              onButtonPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Recover account'),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight - appBarHeight,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/forgot-password-image.png',
                        height: MediaQuery.of(context).size.height * 0.2),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Recover account',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'Righteous',
                        color: Colors.green,
                      ),
                    ),
                  ],
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'someone@example.com',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () =>
                      recoverAccount(emailTextController.text.trim()),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.05),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.green))),
                  child: Text(
                    'Recover',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
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
