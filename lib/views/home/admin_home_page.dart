import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/routing_path.dart';
import 'package:food_app/core/services/menu_service.dart';
import 'package:food_app/core/services/navigation.dart';
import 'package:food_app/core/utils/text.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/views/home/components/admin_food_card.dart';

class AdminHomeView extends ConsumerWidget {
  AdminHomeView({super.key});

  NavigationService navigationService = NavigationService.instance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: ref.read(menuServiceProvider).selectedMenu,
        builder: (BuildContext context, FoodModel selectedMenu, _) {
          var menuService = ref.read(menuServiceProvider);
          return Scaffold(
            body: SafeArea(
              child: menuService.menu.isEmpty
                  ? Center(
                      child: AppText.regular("No menu is on display"),
                    )
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    child: Column(
                        children: [
                          ...List.generate(
                            menuService.menu.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: AdminFoodCard(
                                image: menuService.menu[index].image,
                                name: menuService.menu[index].name,
                                description: menuService.menu[index].description,
                                price: menuService.menu[index].price,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigationService.navigateTo(NavigatorRoutes.menuDetailView);
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
