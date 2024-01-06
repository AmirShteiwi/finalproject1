import 'package:diet_app/constants/app_bar.dart';
import 'package:diet_app/data_models/diet_plan_model.dart';
import 'package:diet_app/provider_model/diet_plan_provider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DietPlanScreen extends StatelessWidget {
  const DietPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dietPlanProvider = context.read<MealPlanProvider>();
    final dietPlan = dietPlanProvider.mealPlans;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Weekly diet plan'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/diet-plan-image.png',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dietPlan.length,
                  itemBuilder: (context, index) {
                    MealPlan mealPlan = dietPlan[index];
                    return ListTile(
                      title: Text(
                        mealPlan.day,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Breakfast',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(mealPlan.breakfast.description),
                          Text(
                              'Amount of calories in meal : ${mealPlan.breakfast.calories} kcal',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic)),
                          const Text(
                            'Lunch',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(mealPlan.lunch.description),
                          Text(
                              'Amount of calories in meal : ${mealPlan.lunch.calories} kcal',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic)),
                          const Text(
                            'Dinner',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(mealPlan.dinner.description),
                          Text(
                              'Amount of calories in meal : ${mealPlan.dinner.calories} kcal',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic)),
                          Text(
                            'Total calories for the day : ${mealPlan.breakfast.calories + mealPlan.lunch.calories + mealPlan.dinner.calories} kcal',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
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
