import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/services/menu_service.dart';
import 'package:food_app/core/utils/colors.dart';
import 'package:food_app/core/utils/text.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/views/home/components/admin_food_card.dart';
import 'package:food_app/views/home/view_model/admin_home_view_model.dart';

final _adminHomeViewModel =
    ChangeNotifierProvider.autoDispose<AdminHomeViewModel>((ref) {
  return AdminHomeViewModel();
});

class AdminHomeView extends ConsumerWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(_adminHomeViewModel);
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
                  : ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                vm.createMenu();
              },
              backgroundColor: AppColors.kPrimaryColor.withOpacity(0.6),
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
