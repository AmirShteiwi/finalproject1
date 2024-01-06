// data_models/meal_plan.dart

class MealPlan {
  final String day;
  final Meal breakfast;
  final Meal lunch;
  final Meal dinner;

  MealPlan({
    required this.day,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });
}

class Meal {
  final String description;
  final int calories;

  Meal({
    required this.description,
    required this.calories,
  });
}
