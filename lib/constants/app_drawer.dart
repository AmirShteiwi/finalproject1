// ignore_for_file: deprecated_member_use

import 'package:diet_app/constants/custom_icons.dart';
import 'package:diet_app/provider_model/home_tab_model.dart';
import 'package:diet_app/screens/drawer_screens/calorie_calculator_screen.dart';
import 'package:diet_app/screens/drawer_screens/calorie_chart_screen.dart';
import 'package:diet_app/screens/drawer_screens/calorie_consumption_screen.dart';
import 'package:diet_app/screens/drawer_screens/weight_loss_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/drawer-logo1.png',
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.2 * 0.7,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<HomeTabModel>().updateSelectedTab(1);
                },
                icon: const Icon(Icons.person, size: 25),
                label: const Text('Profile'),
                style: TextButton.styleFrom(
                  fixedSize: const Size(double.maxFinite, 50),
                  iconColor: Colors.green,
                  backgroundColor: const Color.fromARGB(190, 189, 189, 189),
                  elevation: 0,
                  primary: Colors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  textStyle: TextStyle(
                      fontSize: 18.sp.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalorieChartScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.fastfood_outlined, size: 25),
                    label: const Text('Calorie chart'),
                    style: TextButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 50),
                      iconColor: Colors.black,
                      backgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      primary: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      textStyle: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(height: 0, thickness: 2),
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalorieCalculatorScren(),
                      ),
                    ),
                    icon: const Icon(Icons.calculate_outlined, size: 25),
                    label: const Text('Calorie calculator'),
                    style: TextButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 50),
                      iconColor: Colors.black,
                      backgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      primary: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      textStyle: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(height: 0, thickness: 2),
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalorieConsumptionScreen(),
                      ),
                    ),
                    icon: const Icon(
                        CustomIcons.icons8_healthy_food_calories_calculator_96,
                        size: 25),
                    label: const Text('Calorie consumption'),
                    style: TextButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 50),
                      iconColor: Colors.black,
                      backgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      primary: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      textStyle: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(height: 0, thickness: 2),
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeightLossScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.trending_down_outlined, size: 25),
                    label: const Text('Weight loss'),
                    style: TextButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 50),
                      iconColor: Colors.black,
                      backgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      primary: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      textStyle: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(height: 0, thickness: 2),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<HomeTabModel>().updateSelectedTab(2);
                },
                icon: const Icon(Icons.call, size: 25),
                label: const Text('Contact us'),
                style: TextButton.styleFrom(
                  fixedSize: const Size(double.maxFinite, 50),
                  iconColor: Colors.green,
                  backgroundColor: const Color.fromARGB(190, 189, 189, 189),
                  elevation: 0,
                  primary: Colors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  textStyle:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
