import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:diet_app/constants/app_bar.dart';
import 'package:diet_app/constants/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_widgets/carousel_render.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPos = 0;

  List<String> listPaths = [
    "assets/images/carousel1.png",
    "assets/images/carousel2.png",
    "assets/images/carousel3.jpg",
  ];

  List<String> listTexts = [
    "Measuring daily energy expenditure aids in managing food intake. Wondering how to determine the ideal calorie count? Find all the answers right here.",
    "Revitalize your routine! Plan meals, track fitness effortlessly. Your path to a healthier you starts here!",
    "Elevate your well-being with our app! Discover mindful meals, yoga, and serene vibes for a healthier lifestyle and weight loss",
  ];

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.green,
      Colors.grey,
      Colors.greenAccent,
    ];

    return Scaffold( backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Home'),
      drawer: const MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/dashboard-image.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      speed: const Duration(milliseconds: 700),
                      'Calorie Craft',
                      textStyle:  TextStyle(
                          fontSize: 40.sp, fontFamily: 'Righteous'),
                      colors: colorizeColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: CarouselSlider.builder(
                    itemCount: listPaths.length,
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentPos = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, _) {
                      return CarouselRender(listTexts[index], listPaths[index]);
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(listPaths.length, (index) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 7.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPos == index
                            ? Colors.green
                            : const Color.fromARGB(102, 121, 119, 119),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
