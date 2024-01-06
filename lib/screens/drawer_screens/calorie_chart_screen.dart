import 'package:diet_app/constants/app_bar.dart';
import 'package:diet_app/provider_model/food_chart_provider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CalorieChartScreen extends StatelessWidget {
  const CalorieChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var foodProvider = context.read<FoodDataProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Calorie chart'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.width * 0.05),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/calorie-chart-image.png',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      child: Text(
                    'Food Item',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text('Amount [grams]',
                          style: TextStyle(fontSize: 16.sp))),
                  Text('Calories [kcal]', style: TextStyle(fontSize: 16.sp))
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: foodProvider.foodItems.length,
                  itemBuilder: (context, index) {
                    var foodItem = foodProvider.foodItems[index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            foodItem.foodName,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )),
                          Expanded(
                            child: Text('${foodItem.amount}g',
                                style: TextStyle(fontSize: 16.sp)),
                          ),
                          Text(
                            '${foodItem.calories} kcal',
                            style: TextStyle(fontSize: 16.sp),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
