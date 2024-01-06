import 'package:diet_app/constants/app_bar.dart';
import 'package:diet_app/provider_model/food_chart_provider_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/calorie_chart.dart';

class CalorieCalculatorScren extends StatefulWidget {
  const CalorieCalculatorScren({super.key});

  @override
  State<CalorieCalculatorScren> createState() => _CalorieCalculatorScrenState();
}

class _CalorieCalculatorScrenState extends State<CalorieCalculatorScren> {
  String selectedFood = '';
  int selectedCalories = 0;
  int selectedAmount = 0;

  int getCalories(String foodName) {
    for (var food in calorieChart) {
      if (food['foodName'] == foodName) {
        return food['caloriesInKcal'];
      }
    }
    return 0;
  }

  int getAmount(String foodName) {
    for (var food in calorieChart) {
      if (food['foodName'] == foodName) {
        return food['amountInGrams'];
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    var foodChartProvider = context.read<FoodDataProvider>();
    var foodsList = foodChartProvider.foodItems;
    return Scaffold( backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Calorie calculator'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/calorie-calculator-image.png',
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.08,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.dialog(
                      showSelectedItems: true,
                      showSearchBox: true,
                      dialogProps: DialogProps(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.green,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.green,
                          ),
                          hintText: 'Search for food items',
                          hintStyle: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15.sp,
                              color: Colors.green),
                        ),
                      ),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 10),
                        labelText: "Select food item",
                        icon: Icon(
                          Icons.fastfood_rounded,
                          color: Colors.green,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    dropdownButtonProps: const DropdownButtonProps(
                        color: Colors.green, icon: Icon(Icons.expand_more)),
                    selectedItem: selectedFood,
                    items: foodsList
                        .map((food) => food.foodName)
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedFood = value ?? '';
                        selectedCalories = getCalories(selectedFood);
                        selectedAmount = getAmount(selectedFood);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 20.sp, color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'The selected food item "',
                          style: TextStyle(fontSize: 20.sp)),
                      TextSpan(
                          text: selectedFood,
                          style:
                              TextStyle(color: Colors.green, fontSize: 20.sp)),
                      TextSpan(
                          text: '" contains ',
                          style: TextStyle(fontSize: 20.sp)),
                      TextSpan(
                          text: '$selectedCalories',
                          style:
                              TextStyle(color: Colors.green, fontSize: 20.sp)),
                      TextSpan(
                          text: ' kilo calories',
                          style: TextStyle(fontSize: 20.sp)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
