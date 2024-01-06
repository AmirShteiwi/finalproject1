import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data_models/food_chart_model.dart';

class FoodDataProvider extends ChangeNotifier {
  List<FoodItem> _foodItems = [];

  List<FoodItem> get foodItems => _foodItems;

  FoodDataProvider() {
    // Initialize the real-time listener when the class is created
    initRealtimeListener();
  }

  Future<void> fetchData() async {
    // Fetch data from Firestore and populate _foodItems
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('foodChart').get();

    _foodItems = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return FoodItem(
        foodName: data['foodName'],
        calories: data['calories'],
        amount: data['amount'],
      );
    }).toList();

    notifyListeners();
  }

  void initRealtimeListener() {
    FirebaseFirestore.instance.collection('foodChart').snapshots().listen(
      (QuerySnapshot snapshot) {
        _foodItems = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return FoodItem(
            foodName: data['foodName'],
            calories: data['calories'],
            amount: data['amount'],
          );
        }).toList();

        notifyListeners();
      },
    );
  }
}
