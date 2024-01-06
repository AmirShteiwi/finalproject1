// providers/meal_plan_provider.dart

// ignore_for_file: avoid_print

import 'package:diet_app/data_models/diet_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealPlanProvider extends ChangeNotifier {
  List<MealPlan> _mealPlans = [];

  List<MealPlan> get mealPlans => _mealPlans;

  Future<void> fetchMealPlans() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('dietPlan').get();

      _mealPlans = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return MealPlan(
          day: doc.id,
          breakfast: Meal(
            description: data['breakfast']['description'],
            calories: data['breakfast']['calories'],
          ),
          lunch: Meal(
            description: data['lunch']['description'],
            calories: data['lunch']['calories'],
          ),
          dinner: Meal(
            description: data['dinner']['description'],
            calories: data['dinner']['calories'],
          ),
        );
      }).toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching meal plans: $error");
    }
  }
}
