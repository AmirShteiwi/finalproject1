import 'package:diet_app/constants/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../constants/alert_dialog.dart';

class CalorieConsumptionScreen extends StatefulWidget {
  const CalorieConsumptionScreen({super.key});

  @override
  State<CalorieConsumptionScreen> createState() =>
      _CalorieConsumptionScreenState();
}

class _CalorieConsumptionScreenState extends State<CalorieConsumptionScreen> {
  String _groupValue = 'Male';
  final List<String> _status = ["Male", "Female"];
  final ageInputController = TextEditingController();
  final weightInputController = TextEditingController();
  final heightInputController = TextEditingController();
  double recommendedCalories = 0;
  String recommendedCaloriesString = '';

  void calculateCalories() {
    if (_groupValue != "" &&
        ageInputController.text.isNotEmpty &&
        weightInputController.text.isNotEmpty &&
        heightInputController.text.isNotEmpty) {
      String gender = _groupValue;
      int age = int.parse(ageInputController.text);
      double weight = double.parse(weightInputController.text);
      double height = double.parse(heightInputController.text);
      double basalMetabolicRate = 0;
      double activityFactor = 1.55;

      if (gender == "Male") {
        basalMetabolicRate =
            88.362 + (13.394 * weight) + (4.799 * height) - (5.677 * age);
      } else {
        basalMetabolicRate =
            447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      }

      setState(() {
        recommendedCalories = basalMetabolicRate * activityFactor;
        recommendedCaloriesString = recommendedCalories.toStringAsFixed(2);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => MyAlertDialog(
          title: 'Invalid selection',
          content:
              'Please select and enter all required values to calculate your recommended calories',
          buttonText: 'Okay',
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Calorie consumption'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Image.asset(
                  'assets/images/calorie-consumption-image.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: _groupValue,
                        horizontalAlignment: MainAxisAlignment.spaceEvenly,
                        onChanged: (value) => setState(() {
                          _groupValue = value ?? '';
                        }),
                        items: _status,
                        textStyle: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                        fillColor: Colors.green,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Age',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.green),
                        controller: ageInputController,
                        decoration: InputDecoration(
                          hintText: '23',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
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
                  children: [
                    Row(
                      children: [
                        Text(
                          'Weight [kg]',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.green),
                        controller: weightInputController,
                        decoration: InputDecoration(
                          hintText: '80',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
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
                  children: [
                    Row(
                      children: [
                        Text(
                          'Height [cm]',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.green),
                        controller: heightInputController,
                        decoration: InputDecoration(
                          hintText: '185.42',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: calculateCalories,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.height * 0.05),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green, width: 0.5)),
                  child: Text(
                    'Calculate calories',
                    style: TextStyle(color: Colors.green, fontSize: 17.sp),
                  ),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: recommendedCalories != 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.green.shade300,
                          Colors.grey
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 3,
                          offset: Offset(3, 5),
                          color: Colors.green,
                        )
                      ],
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 20.sp, color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  'The recommended amount of calories you should consume in a day are : ',
                              style: TextStyle(fontSize: 18.sp)),
                          TextSpan(
                              text: recommendedCaloriesString,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 18.sp)),
                          TextSpan(
                              text: ' kcal', style: TextStyle(fontSize: 18.sp)),
                        ],
                      ),
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
