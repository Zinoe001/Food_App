import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/food_model.dart';

class MenuService {
  /// create a list of cities
  List<FoodModel> menu = [];

  /// create a value listener
  final ValueNotifier<FoodModel> _selectedMenu = ValueNotifier(FoodModel(
    image: File(""),
    name: '',
    description: '',
    price: '',
  ));

  /// create an instance of the value listener
  ValueNotifier<FoodModel> get selectedMenu => _selectedMenu;

  /// create a method
  void addMenu(FoodModel value) {
       menu.add(value);
  }
}

/// create a provider instance of the listener
final menuServiceProvider = Provider((ref) => MenuService());

