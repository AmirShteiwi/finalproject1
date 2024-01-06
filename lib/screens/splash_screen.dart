import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, '/sign-in-screen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold( backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        height: deviceHeight,
        width: deviceWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.2),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/splash-logo.png',
                  fit: BoxFit.contain,
                  height: deviceHeight * 0.25,
                ),
                Column(
                  children: [
                    Text(
                      'Calorie Craft',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 30.sp,
                          fontFamily: 'Righteous'),
                    ),
                    Text(
                      'Crafting health & Creating happiness',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.sp,
                          fontFamily: 'Lato'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
