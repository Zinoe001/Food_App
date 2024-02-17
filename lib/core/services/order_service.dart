import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/food_model.dart';

class OrderService {
  /// create a list of orders
  List<FoodModel> order = [];

  /// create a value listener
  final ValueNotifier<FoodModel> _selectedOrder = ValueNotifier(FoodModel(
    image: File(""),
    name: '',
    description: '',
    price: '',
  ));

  /// create an instance of the value listener
  ValueNotifier<FoodModel> get selectedOrder => _selectedOrder;

  /// create a method
  void addOrder(FoodModel value) {
    order.add(value);
  }

  /// create a method
  void removeOrder(FoodModel value) {
    order.removeWhere((element) => value.name == element.name);
  }
}

/// create a provider instance of the listener
final orderServiceProvider = Provider((ref) => OrderService());
